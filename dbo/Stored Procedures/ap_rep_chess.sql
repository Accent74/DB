--------------------------------------------
create procedure ap_rep_chess
@plan int,
@crc int,
@start datetime,
@end datetime,
@mcid int
as
set nocount on
if @crc = 1
  select 
    JOURNAL.ACC_DB, JOURNAL.ACC_CR, sum(JOURNAL.J_SUM)
  from (JOURNAL inner join ACCOUNTS as AD on JOURNAL.ACC_DB = AD.ACC_ID)
    inner join ACCOUNTS as AC on JOURNAL.ACC_CR = AC.ACC_ID 
  where 
    JOURNAL.MC_ID=@mcid and JOURNAL.J_DONE=2 and JOURNAL.J_DATE>=@start and JOURNAL.J_DATE<@end
    and AD.ACC_PLAN=@plan and AC.ACC_PLAN=@plan
  group by 
    JOURNAL.ACC_DB, JOURNAL.ACC_CR
  having sum(JOURNAL.J_SUM)<>0
else
  select 
    JOURNAL.ACC_DB, JOURNAL.ACC_CR, sum(JRN_CRC.JC_SUM)
  from ((JOURNAL inner join JRN_CRC on JOURNAL.J_ID=JRN_CRC.J_ID) 
    inner join ACCOUNTS as AD on JOURNAL.ACC_DB = AD.ACC_ID)
    inner join ACCOUNTS as AC on JOURNAL.ACC_CR = AC.ACC_ID 
  where 
    JOURNAL.MC_ID=@mcid and JOURNAL.J_DONE=2 and JOURNAL.J_DATE >= @start and JOURNAL.J_DATE<@end 
    and AD.ACC_PLAN=@plan and AC.ACC_PLAN=@plan
    and JRN_CRC.CRC_ID=@crc 
  group by 
    JOURNAL.ACC_DB, JOURNAL.ACC_CR
  having sum(JRN_CRC.JC_SUM)<>0


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_rep_chess] TO [ap_public]
    AS [dbo];

