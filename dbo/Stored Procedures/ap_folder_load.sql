---------------------------------------------
create procedure ap_folder_load
@id int
as
set nocount on
select 
  FOLDERS.FLD_NAME, FOLDERS.FLD_TAG, 
  FOLDERS.FLD_MEMO, FOLDERS.TML_ID, 
  FOLDERS.FRM_ID, FOLDERS.FLD_GUID,
  FOLDERS.FLD_SYSCODE
from FOLDERS where FLD_ID=@id

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_folder_load] TO [ap_public]
    AS [dbo];

