----------------------------------------
create procedure ap_form_loadall
as
set nocount on
select 
  FRM_ID, FRM_TYPE, FRM_NAME,FRM_FILE,FRM_SHORT,
  FRM_MEMO,FRM_PARENT,FA_ID,FLD_ID,FRM_TAG
from 
  FORMS


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_form_loadall] TO [ap_public]
    AS [dbo];

