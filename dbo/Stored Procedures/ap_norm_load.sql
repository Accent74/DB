-----------------------------------------
create procedure ap_norm_load
@id int = 0
as
set nocount on
if @id = 0
  select NRM_ID, NRM_NAME, NRM_CODE, NRM_XNAME, NRM_YNAME, NRM_MEMO from NORMS
else
  select NRM_ID, NRM_NAME, NRM_CODE, NRM_XNAME, NRM_YNAME, NRM_MEMO from NORMS
  where NRM_ID=@id

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_norm_load] TO [ap_public]
    AS [dbo];

