----------------------------------------
create procedure ap_jrnload2_folder 
@id int,
@sd datetime,
@ed datetime,
@mcid int
as
set nocount on
Select DOCUMENTS.DOC_ID, MAX(J_TR_NO), ST_ID, FLD_ID
from DOCUMENTS inner Join JOURNAL On DOCUMENTS.DOC_ID = JOURNAL.DOC_ID
where DOCUMENTS.MC_ID=@mcid and DOC_DONE<100 And (DOC_DATE>=@sd And DOC_DATE<@ed ) And DOCUMENTS.FLD_ID=@id
group by DOCUMENTS.DOC_ID, DOCUMENTS.ST_ID, DOCUMENTS.DOC_DATE, FLD_ID
order by DOC_DATE, DOCUMENTS.DOC_ID

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_jrnload2_folder] TO [ap_public]
    AS [dbo];

