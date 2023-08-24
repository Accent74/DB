----------------------------------------
create procedure ap_account_delete
@id int
as
set nocount on
begin tran
delete from ACCOUNTS where ACC_ID=@id
exec ap_log_add N'A',N'D',@id
commit


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_account_delete] TO [ap_public]
    AS [dbo];

