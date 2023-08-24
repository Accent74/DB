-----------------------------------------
create procedure ap_prprice_delete
@id int
as
set nocount on
begin tran
delete from PRL_PRICES where PRLPC=@id
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_prprice_delete] TO [ap_public]
    AS [dbo];

