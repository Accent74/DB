----------------------------------------
create procedure ap_entunit_delete
@id int
as
set nocount on
begin tran
delete from ENT_UNITS where EU_PK=@id
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_entunit_delete] TO [ap_public]
    AS [dbo];

