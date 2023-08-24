----------------------------------------
create procedure ap_rep_cross
@sd datetime,
@ed datetime,
@crc int,
@plan int,
@mcid int
as
set nocount on
if @crc = 1
begin
select JOURNAL.J_AG1,JOURNAL.J_AG2,JOURNAL.J_ENT,
  JOURNAL.J_SUM, JOURNAL.J_QTY, DOCUMENTS.DOC_NAME, DOCUMENTS.DOC_NO, DOCUMENTS.FRM_ID, 
  JOURNAL.ACC_DB, JOURNAL.ACC_CR 
  from ((JOURNAL inner join DOCUMENTS on JOURNAL.DOC_ID = DOCUMENTS.DOC_ID) 
  inner join ACCOUNTS as AD on JOURNAL.ACC_DB=AD.ACC_ID) 
  inner join ACCOUNTS as AC on JOURNAL.ACC_CR=AC.ACC_ID 
  where JOURNAL.MC_ID=@mcid and JOURNAL.J_DONE=2 and JOURNAL.J_DATE>=@sd and 
  JOURNAL.J_DATE<@ed and AD.ACC_PLAN = @plan and AC.ACC_PLAN=@plan
end
else
begin
select JOURNAL.J_AG1,JOURNAL.J_AG2,JOURNAL.J_ENT,
  JRN_CRC.JC_SUM, JOURNAL.J_QTY, DOCUMENTS.DOC_NAME, DOCUMENTS.DOC_NO, DOCUMENTS.FRM_ID,
  JOURNAL.ACC_DB, JOURNAL.ACC_CR 
  from (((JOURNAL inner join DOCUMENTS on JOURNAL.DOC_ID = DOCUMENTS.DOC_ID) 
  inner join ACCOUNTS as AD on JOURNAL.ACC_DB=AD.ACC_ID) 
  inner join ACCOUNTS as AC on JOURNAL.ACC_CR=AC.ACC_ID) 
  inner join JRN_CRC on JRN_CRC.J_ID = JOURNAL.J_ID 
  where JOURNAL.MC_ID=@mcid and JOURNAL.J_DONE=2 AND JOURNAL.J_DATE>=@sd and JOURNAL.J_DATE<@ed 
  and JRN_CRC.CRC_ID=@crc and AD.ACC_PLAN = @plan and AC.ACC_PLAN=@plan
end

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_rep_cross] TO [ap_public]
    AS [dbo];

