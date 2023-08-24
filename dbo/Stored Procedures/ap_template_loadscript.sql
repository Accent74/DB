---------------------------------------------------------------------
create procedure ap_template_loadscript
@id int
as
set nocount on
select TML_SCRIPT,FRM_ID,TML_NAME from TEMPLATES where TML_ID=@id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_template_loadscript] TO [ap_public]
    AS [dbo];

