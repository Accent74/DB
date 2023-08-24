---------------------------------------------
create procedure ap_rep_synth3
@acc int,
@crc int,
@sd datetime,
@ed datetime,
@mcid int
as
set nocount on

if @crc = 1
  select sum(JOURNAL.J_SUM) as S, JOURNAL.ACC_CR as ACC, cast(0 as smallint) as CR    
  from JOURNAL 
  where JOURNAL.MC_ID=@mcid and JOURNAL.ACC_DB=@acc and JOURNAL.J_DONE=2 and 
    JOURNAL.J_DATE >=@sd and JOURNAL.J_DATE<@ed
  group by JOURNAL.ACC_CR
  union
  select sum(JOURNAL.J_SUM) as S, JOURNAL.ACC_DB as ACC, cast(1 as smallint) as CR
  from JOURNAL
  where JOURNAL.MC_ID=@mcid and JOURNAL.ACC_CR=@acc and JOURNAL.J_DONE=2 and 
    JOURNAL.J_DATE >=@sd and JOURNAL.J_DATE<@ed
  group by JOURNAL.ACC_DB
else 
  select sum(JRN_CRC.JC_SUM) as S, JOURNAL.ACC_CR as ACC, cast(0 as smallint) as CR
  from JOURNAL inner join JRN_CRC on JOURNAL.J_ID=JRN_CRC.J_ID 
  where JOURNAL.MC_ID=@mcid and JOURNAL.ACC_DB=@acc and JOURNAL.J_DONE=2 and
    JOURNAL.J_DATE >=@sd and JOURNAL.J_DATE<@ed and JRN_CRC.CRC_ID=@crc 
  group by JOURNAL.ACC_CR
  union 
  select sum(JRN_CRC.JC_SUM) as S, JOURNAL.ACC_DB as ACC, cast(1 as smallint) as CR
  from JOURNAL inner join JRN_CRC on JOURNAL.J_ID=JRN_CRC.J_ID 
  where JOURNAL.MC_ID=@mcid and JOURNAL.ACC_CR=@acc and JOURNAL.J_DONE=2 and
    JOURNAL.J_DATE >=@sd and JOURNAL.J_DATE<@ed and JRN_CRC.CRC_ID=@crc 
  group by JOURNAL.ACC_DB

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_rep_synth3] TO [ap_public]
    AS [dbo];

