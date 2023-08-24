----------------------------------------
create procedure ap_jrnload2_binder 
@id int,
@sd datetime,
@ed datetime,
@mcid int
AS
set nocount on
Select DOCUMENTS.DOC_ID, max(J_TR_NO), ST_ID, FLD_ID
from DOCUMENTS inner Join JOURNAL On DOCUMENTS.DOC_ID = JOURNAL.DOC_ID 
where DOCUMENTS.MC_ID=@mcid and DOC_DONE < 100 And ((DOC_DATE>=@sd And DOC_DATE <@ed)) And DOCUMENTS.DOC_ID In (Select DOC_ID from BIND_DOCS where BIND_ID=@id)
group by DOCUMENTS.DOC_ID, DOC_DATE, ST_ID, FLD_ID 
order by DOCUMENTS.DOC_DATE, DOCUMENTS.DOC_ID

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_jrnload2_binder] TO [ap_public]
    AS [dbo];

