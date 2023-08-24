----------------------------------------
create procedure ap_template_unlink
@id int,
@dt datetime,
@mc int
as
set nocount on
update DOCUMENTS set TML_ID=null where TML_ID=@id and DOC_DATE<@dt and MC_ID=@mc

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_template_unlink] TO [ap_public]
    AS [dbo];

