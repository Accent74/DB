---------------------------------------------------------------------
create procedure ap_account_rename 
@id int, @name nvarchar(256)
as
set nocount on
begin tran
update ACCOUNTS set ACC_NAME=@name where ACC_ID=@id
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_account_rename] TO [ap_public]
    AS [dbo];

