----------------------------------------
create procedure ap_operation_tobinder
@id int,
@bind int
as
set nocount on
begin tran
if not exists(select * from BIND_DOCS where DOC_ID=@id and BIND_ID=@bind)
begin
  insert into BIND_DOCS (DOC_ID,BIND_ID) values (@id,@bind)
end

commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_operation_tobinder] TO [ap_public]
    AS [dbo];

