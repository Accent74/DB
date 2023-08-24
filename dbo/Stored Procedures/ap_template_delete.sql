---------------------------------------------------------------------
create procedure ap_template_delete
@id int
as
set nocount on
begin tran
delete from TEMPLATES where TML_ID=@id
exec ap_log_add N'T',N'D',@id
commit


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_template_delete] TO [ap_public]
    AS [dbo];

