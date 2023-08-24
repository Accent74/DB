--------------------------------------------
create procedure ap_rep_cbalance
@plan int,
@crc int,
@start datetime,
@end datetime,
@mcid int
as
set nocount on

-- start cr
select ACCOUNTS.ACC_ID, sum(isnull(JRN_CRC.JC_SUM,0)) AS SCR 
into #mto_scr
from (ACCOUNTS inner join JOURNAL on ACCOUNTS.ACC_ID = JOURNAL.ACC_CR) 
  inner join JRN_CRC on JRN_CRC.J_ID=JOURNAL.J_ID
where JOURNAL.MC_ID=@mcid and JOURNAL.J_DONE=2 and ACCOUNTS.ACC_PLAN=@plan and ACCOUNTS.ACC_TYPE>=0 
  and ACCOUNTS.ACC_TYPE < 3 and JOURNAL.J_DATE < @start and JRN_CRC.CRC_ID=@crc
group by ACCOUNTS.ACC_ID
-- start db
select ACCOUNTS.ACC_ID, sum(isnull(JRN_CRC.JC_SUM,0)) as SDB 
into #mto_sdb
from (ACCOUNTS inner join JOURNAL on ACCOUNTS.ACC_ID = JOURNAL.ACC_DB)
  inner join JRN_CRC on JRN_CRC.J_ID=JOURNAL.J_ID
where JOURNAL.MC_ID=@mcid and JOURNAL.J_DONE=2 and ACCOUNTS.ACC_PLAN=@plan and ACCOUNTS.ACC_TYPE>=0 
  and ACCOUNTS.ACC_TYPE < 3 and JOURNAL.J_DATE < @start and JRN_CRC.CRC_ID=@crc
group by ACCOUNTS.ACC_ID
-- turn cr
select ACCOUNTS.ACC_ID, sum(isnull(JRN_CRC.JC_SUM,0)) as TCR
into #mto_tcr
from (ACCOUNTS inner join JOURNAL on ACCOUNTS.ACC_ID = JOURNAL.ACC_CR)
  inner join JRN_CRC on JRN_CRC.J_ID=JOURNAL.J_ID
where JOURNAL.MC_ID=@mcid and JOURNAL.J_DONE=2 and ACCOUNTS.ACC_PLAN=@plan and ACCOUNTS.ACC_TYPE>=0 
  and ACCOUNTS.ACC_TYPE < 3 and JOURNAL.J_DATE >= @start and JOURNAL.J_DATE<@end
  and JRN_CRC.CRC_ID=@crc
group by ACCOUNTS.ACC_ID
-- turn db
select ACCOUNTS.ACC_ID, sum(isnull(JRN_CRC.JC_SUM,0)) as TDB
into #mto_tdb
from (ACCOUNTS inner join JOURNAL on ACCOUNTS.ACC_ID = JOURNAL.ACC_DB)
  inner join JRN_CRC on JRN_CRC.J_ID=JOURNAL.J_ID
where JOURNAL.MC_ID=@mcid and JOURNAL.J_DONE=2 and ACCOUNTS.ACC_PLAN=@plan and ACCOUNTS.ACC_TYPE>=0 
  and ACCOUNTS.ACC_TYPE < 3 and JOURNAL.J_DATE >= @start and JOURNAL.J_DATE<@end
  and JRN_CRC.CRC_ID=@crc
group by ACCOUNTS.ACC_ID

-- common table
select 
  ACCOUNTS.ACC_ID,ACCOUNTS.ACC_TYPE,ACCOUNTS.ACC_S_TYPE,ACCOUNTS.ACC_T_TYPE,
  #mto_sdb.SDB, #mto_scr.SCR, #mto_tdb.TDB, #mto_tcr.TCR, cast(0 as money) as EDB, cast(0 as money) as ECR
into #main
from (((ACCOUNTS left join #mto_scr on ACCOUNTS.ACC_ID = #mto_scr.ACC_ID) 
  left join #mto_sdb on ACCOUNTS.ACC_ID = #mto_sdb.ACC_ID) 
  left join #mto_tcr on ACCOUNTS.ACC_ID = #mto_tcr.ACC_ID) 
  left join #mto_tdb on ACCOUNTS.ACC_ID = #mto_tdb.ACC_ID
--where (#mto_sdb.SDB <> 0 or #mto_scr.SCR <> 0 or #mto_tdb.TDB <> 0 or #mto_tcr.TCR <> 0) 
where ACCOUNTS.ACC_TYPE>=0 and ACCOUNTS.ACC_TYPE<3 and ACCOUNTS.ACC_PLAN=@plan
order by ACCOUNTS.ACC_CODE

update #main set SDB=0 where SDB is null
update #main set SCR=0 where SCR is null
update #main set TDB=0 where TDB is null
update #main set TCR=0 where TCR is null

-- collapse start saldo
update #main
  set SDB = case
    when SDB > SCR then SDB - SCR        
    else 0
  end,
  SCR = case
    when SCR > SDB then SCR - SDB        
    else 0
  end
where #main.ACC_TYPE=0 or #main.ACC_TYPE=1

-- calc end saldo
update #main set EDB = SDB + TDB,ECR = SCR + TCR  

-- collaps end saldo
update #main
  set EDB = case
    when EDB > ECR then EDB - ECR        
    else 0
  end,
  ECR = case
    when ECR > EDB then ECR - EDB        
    else 0
  end
where #main.ACC_TYPE=0 or #main.ACC_TYPE=1

declare #balcrs cursor local fast_forward read_only for
  select ACC_ID,ACC_S_TYPE from #main where ACC_TYPE=2

declare @acc_id int, @acc_saldo smallint
declare @sdb money, @scr money, @tdb money, @tcr money, @edb money, @ecr money
select @sdb = 0, @scr = 0, @tdb = 0, @tcr = 0, @edb = 0, @ecr = 0
open #balcrs
fetch next from #balcrs into @acc_id,@acc_saldo
while @@fetch_status = 0
  begin
     -- check collapse
     if @acc_saldo = 1 -- collapse by agents
       begin
        exec ap_clpsc_agent @acc_id,@crc, @start, @end, @mcid, @sdb OUT, @scr OUT, @tdb OUT, @tcr OUT, @edb OUT, @ecr OUT
        -- update main table
        update #main set SDB=@sdb, SCR=@scr, TDB=@tdb, TCR=@tcr, EDB=@edb, ECR=@ecr
        where ACC_ID=@acc_id
       end
     else if @acc_saldo = 2 -- collapse by entities
       begin
        exec ap_clpsc_entity @acc_id,@crc,@start, @end, @mcid, @sdb OUT, @scr OUT, @tdb OUT, @tcr OUT, @edb OUT, @ecr OUT
        -- update main table
        update #main set SDB=@sdb, SCR=@scr, TDB=@tdb, TCR=@tcr, EDB=@edb, ECR=@ecr
        where ACC_ID=@acc_id
      end

     fetch next from #balcrs into @acc_id,@acc_saldo
  end

close #balcrs
deallocate #balcrs

select ACC_ID,ACC_TYPE,ACC_S_TYPE,ACC_T_TYPE,SDB,SCR,TDB,TCR,EDB,ECR from #main

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_rep_cbalance] TO [ap_public]
    AS [dbo];

