----------------------------------------------------
create procedure ap_external_delete
@id int
as
set nocount on
begin tran
delete FROM EXT_DOCS where EXT_ID=@id
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_external_delete] TO [ap_public]
    AS [dbo];

