---------------------------------------------------------------------
create procedure ap_template_load
@id int
as
set nocount on
select TML_TYPE,TML_NAME,TML_TAG,TML_MEMO,FRM_ID,TML_GUID,TML_HIDDEN
from TEMPLATES 
where TML_ID=@id

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_template_load] TO [ap_public]
    AS [dbo];

