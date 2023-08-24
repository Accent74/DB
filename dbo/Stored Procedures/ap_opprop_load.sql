--------------------------------------------
create procedure ap_opprop_load
@id int
as
set nocount on
select 
  DOCUMENTS.DOC_NAME, DOCUMENTS.DOC_TAG, DOCUMENTS.DOC_MEMO, 
  DOCUMENTS.TML_ID,DOCUMENTS.LAST_DATE, DOCUMENTS.FLD_ID, DOCUMENTS.ST_ID,
  DOCUMENTS.DOC_XSTATUS
from DOCUMENTS where DOC_ID=@id

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_opprop_load] TO [ap_public]
    AS [dbo];

