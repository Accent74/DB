--------------------------------------------
create procedure ap_operation_frombinder
@id int,
@bind int
as
set nocount on
begin tran
delete from BIND_DOCS where DOC_ID=@id AND BIND_ID=@bind
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_operation_frombinder] TO [ap_public]
    AS [dbo];

