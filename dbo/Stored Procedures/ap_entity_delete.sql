----------------------------------------
create procedure ap_entity_delete
@id int
as
set nocount on
begin tran
delete from ENTITIES where ENT_ID=@id
exec ap_log_add N'E',N'D',@id
commit


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_entity_delete] TO [ap_public]
    AS [dbo];

