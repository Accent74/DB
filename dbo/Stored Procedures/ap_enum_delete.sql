----------------------------------------
create procedure ap_enum_delete
@id int
as
set nocount on
delete from ENUMS where ENM_ID=@id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_enum_delete] TO [ap_public]
    AS [dbo];

