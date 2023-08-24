----------------------------------------
create procedure ap_jrnload2_favorites
@id int,
@sd datetime,
@ed datetime,
@mcid int
as
set nocount on
Select DOCUMENTS.DOC_ID, max(JOURNAL.J_TR_NO), ST_ID, FLD_ID
from DOCUMENTS inner Join JOURNAL On DOCUMENTS.DOC_ID = JOURNAL.DOC_ID
where DOCUMENTS.MC_ID=@mcid and
			DOCUMENTS.DOC_ID in (select F_REF from FAVORITES where F_KIND=0 AND F_PARENT=@id)    
group by DOCUMENTS.DOC_ID, DOCUMENTS.ST_ID, DOCUMENTS.DOC_DATE, FLD_ID
order by DOC_DATE, DOCUMENTS.DOC_ID

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_jrnload2_favorites] TO [ap_public]
    AS [dbo];

