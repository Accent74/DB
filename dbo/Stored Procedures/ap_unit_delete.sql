---------------------------------------------------------------------
create procedure ap_unit_delete 
@id int
as
set nocount on
delete from UNITS where UN_ID=@id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_unit_delete] TO [ap_public]
    AS [dbo];

