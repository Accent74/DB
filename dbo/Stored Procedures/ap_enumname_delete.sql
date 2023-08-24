----------------------------------------
create procedure ap_enumname_delete
@id int
as
set nocount on

delete from ENUM_NAMES where ENN_ID=@id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_enumname_delete] TO [ap_public]
    AS [dbo];

