----------------------------------------
create procedure ap_entity_rename 
@id int, 
@name nvarchar(256)
as
set nocount on
begin tran
update ENTITIES set ENT_NAME=@name where ENT_ID=@id
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_entity_rename] TO [ap_public]
    AS [dbo];

