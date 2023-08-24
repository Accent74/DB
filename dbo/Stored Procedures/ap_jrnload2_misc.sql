----------------------------------------
create procedure ap_jrnload2_misc 
@id int,
@sd datetime,
@ed datetime,
@mcid int
AS
set nocount on
declare @no int
declare @tp smallint
Select @no = MSC_NO, @tp=MSC_TYPE from MISC where MSC_ID=@id
if @tp = -1
  select null, null, null, null where 1<>1
else
Select DOCUMENTS.DOC_ID, (Select max(J.J_TR_NO) from JOURNAL J where J.DOC_ID=DOCUMENTS.DOC_ID), ST_ID, FLD_ID
from (DOCUMENTS inner Join JOURNAL On DOCUMENTS.DOC_ID = JOURNAL.DOC_ID)
inner Join JRN_MISC On JOURNAL.J_ID = JRN_MISC.J_ID 
where DOCUMENTS.MC_ID=@mcid and DOC_DONE<100 And ((DOC_DATE>=@sd And DOC_DATE <@ed)) And JRN_MISC.MSC_ID=@id And JRN_MISC.MSC_NO=@no
group by DOCUMENTS.DOC_ID, DOCUMENTS.ST_ID, DOCUMENTS.DOC_DATE, FLD_ID
order by DOC_DATE, DOCUMENTS.DOC_ID

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_jrnload2_misc] TO [ap_public]
    AS [dbo];

