----------------------------------------
create procedure ap_rtname_delete
@id int
as
set nocount on
begin tran
delete from CRC_RT_NAMES where RT_ID=@id
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_rtname_delete] TO [ap_public]
    AS [dbo];

