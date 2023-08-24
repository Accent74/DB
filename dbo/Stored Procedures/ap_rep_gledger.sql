---------------------------------------------
create procedure ap_rep_gledger
@acc int,
@crc int,
@sd datetime,
@ed datetime,
@mcid int
as
set nocount on
if @crc=1
  select datepart(month,J_DATE), sum(JOURNAL.J_SUM), JOURNAL.ACC_CR, JOURNAL.ACC_DB 
  from JOURNAL 
  where JOURNAL.MC_ID=@mcid and JOURNAL.J_DONE=2 and (ACC_DB=@acc OR ACC_CR=@acc) and 
        J_DATE>=@sd and J_DATE<@ed
  group by datepart(month,J_DATE), JOURNAL.ACC_CR, JOURNAL.ACC_DB 
  having sum(JOURNAL.J_SUM) <> 0 
else
  select datepart(month,J_DATE), sum(JRN_CRC.JC_SUM), JOURNAL.ACC_CR, JOURNAL.ACC_DB 
  from JOURNAL inner join JRN_CRC on JOURNAL.J_ID=JRN_CRC.J_ID
  where JOURNAL.MC_ID=@mcid and JOURNAL.J_DONE=2 and (ACC_DB=@acc OR ACC_CR=@acc) and 
        J_DATE>=@sd and J_DATE<@ed and JRN_CRC.CRC_ID=@crc
  group by datepart(month,J_DATE), JOURNAL.ACC_CR, JOURNAL.ACC_DB 
  having sum(JOURNAL.J_SUM) <> 0

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_rep_gledger] TO [ap_public]
    AS [dbo];

