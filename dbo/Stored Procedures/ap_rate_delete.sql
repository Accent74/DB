----------------------------------------
create procedure ap_rate_delete 
@id int 
as
set nocount on
begin tran
delete from CRC_RATES where PK=@id
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_rate_delete] TO [ap_public]
    AS [dbo];

