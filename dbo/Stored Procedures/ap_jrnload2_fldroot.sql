----------------------------------------
create procedure ap_jrnload2_fldroot
@sd datetime,
@ed datetime,
@mcid int 
as
set nocount on
Select DOCUMENTS.DOC_ID, max(JOURNAL.J_TR_NO), DOCUMENTS.ST_ID, FLD_ID 
from DOCUMENTS inner Join JOURNAL On DOCUMENTS.DOC_ID = JOURNAL.DOC_ID
where DOCUMENTS.MC_ID=@mcid and DOC_DONE<100 And (DOC_DATE>=@sd And DOC_DATE<@ed) And
(DOCUMENTS.FLD_ID is NULL or DOCUMENTS.FLD_ID = 0) 
group by DOCUMENTS.DOC_ID, DOCUMENTS.ST_ID, DOCUMENTS.DOC_DATE, FLD_ID
order by DOCUMENTS.DOC_DATE, DOCUMENTS.DOC_ID

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_jrnload2_fldroot] TO [ap_public]
    AS [dbo];

