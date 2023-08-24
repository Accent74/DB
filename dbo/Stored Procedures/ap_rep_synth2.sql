---------------------------------------------
create procedure ap_rep_synth2
@acc int,
@crc int,
@sd datetime,
@ed datetime,
@mcid int
as
set nocount on

if @crc = 1
  select JOURNAL.J_DATE, JOURNAL.ACC_DB, JOURNAL.ACC_CR, 
    sum(JOURNAL.J_SUM) as S
  from JOURNAL 
  where JOURNAL.MC_ID=@mcid and (JOURNAL.ACC_DB=@acc or JOURNAL.ACC_CR=@acc) and JOURNAL.J_DONE=2 and 
    JOURNAL.J_DATE >=@sd and  JOURNAL.J_DATE<@ed 
  group by JOURNAL.J_DATE, JOURNAL.ACC_DB, JOURNAL.ACC_CR 
  order by JOURNAL.J_DATE
else 
  select JOURNAL.J_DATE, JOURNAL.ACC_DB, JOURNAL.ACC_CR,
    sum(JRN_CRC.JC_SUM) as S 
  from JOURNAL inner join JRN_CRC on JOURNAL.J_ID=JRN_CRC.J_ID 
  where JOURNAL.MC_ID=@mcid and (JOURNAL.ACC_DB=@acc or JOURNAL.ACC_CR=@acc) and JOURNAL.J_DONE=2 and
  JOURNAL.J_DATE >=@sd and JOURNAL.J_DATE<@ed and JRN_CRC.CRC_ID=@crc 
  group by JOURNAL.J_DATE, JOURNAL.ACC_DB, JOURNAL.ACC_CR 
  order by JOURNAL.J_DATE

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_rep_synth2] TO [ap_public]
    AS [dbo];

