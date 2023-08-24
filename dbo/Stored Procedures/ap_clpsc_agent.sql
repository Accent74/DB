--------------------------------------------
create procedure ap_clpsc_agent
@accid int,
@crcid int,
@start datetime,
@end datetime,
@mcid int,
@sd money OUTPUT,
@sc money OUTPUT,
@td money OUTPUT,
@tc money OUTPUT,
@ed money OUTPUT,
@ec money OUTPUT
as 
set nocount on
select @sd = 0, @sc = 0, @td = 0, @tc = 0, @ed=0, @ec = 0

create table #clps
  (AG int, SDB money, SCR money, TDB money, TCR money)
insert into #clps
select JOURNAL.J_AG1 as AG, sum(isnull(JRN_CRC.JC_SUM,0)) as SDB, 0 as SCR, 0 as TDB, 0 as TCR
from JOURNAL inner join JRN_CRC on JRN_CRC.J_ID=JOURNAL.J_ID
where JOURNAL.MC_ID=@mcid and J_DONE=2 and J_DATE<@start and JOURNAL.ACC_DB=@accid and JRN_CRC.CRC_ID=@crcid
group by JOURNAL.J_AG1
union
select JOURNAL.J_AG2 as AG, 0 as SDB, sum(isnull(JRN_CRC.JC_SUM,0)) as SCR,0 as TDB, 0 as TCR
from JOURNAL inner join JRN_CRC on JRN_CRC.J_ID=JOURNAL.J_ID
where JOURNAL.MC_ID=@mcid and J_DONE=2 and J_DATE<@start and JOURNAL.ACC_CR=@accid and JRN_CRC.CRC_ID=@crcid
group by JOURNAL.J_AG2
union 
select JOURNAL.J_AG1 as AG, 0 as SDB, 0 as SCR, sum(isnull(JRN_CRC.JC_SUM,0)) as TDB, 0 as TCR
from JOURNAL inner join JRN_CRC on JRN_CRC.J_ID=JOURNAL.J_ID
where JOURNAL.MC_ID=@mcid and J_DONE=2 and J_DATE>=@start and J_DATE<@end and ACC_DB=@accid and JRN_CRC.CRC_ID=@crcid
group by JOURNAL.J_AG1
union
select JOURNAL.J_AG2 as AG, 0 as SDB, 0 as SCR, 0 as TDB, sum(isnull(JRN_CRC.JC_SUM,0)) as TCR
from JOURNAL inner join JRN_CRC on JRN_CRC.J_ID=JOURNAL.J_ID
where JOURNAL.MC_ID=@mcid and J_DONE=2 and J_DATE>=@start and J_DATE<@end and ACC_CR=@accid and JRN_CRC.CRC_ID=@crcid
group by JOURNAL.J_AG2

select AG, sum(SDB) as SDB,sum(SCR) as SCR, sum(TDB) as TDB, sum(TCR) as TCR, cast(0 as money) as EDB, cast(0 as money) as ECR
into #restbl from #clps group by AG

-- collapse start
update #restbl
  set SDB = case
    when SDB > SCR then SDB - SCR        
    else 0
  end,
  SCR = case
    when SCR > SDB then SCR - SDB        
    else 0
  end
-- calc end saldo
update #restbl set EDB=SDB+TDB, ECR=SCR+TCR

-- collapse end
update #restbl
  set EDB = case
    when EDB > ECR then EDB - ECR        
    else 0
  end,
  ECR = case
    when ECR > EDB then ECR - EDB        
    else 0
  end

select @sd = sum(SDB), @sc=sum(SCR), @td=sum(TDB), @tc=sum(TCR), @ed=sum(EDB), @ec=sum(ECR)
from #restbl

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_clpsc_agent] TO [ap_public]
    AS [dbo];

