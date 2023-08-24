---------------------------------------------------------------------
create procedure ap_binder_rename 
@id int, @name nvarchar(256)
as
set nocount on
begin tran
update BINDERS set BIND_NAME=@name where BIND_ID=@id
commit tran



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_binder_rename] TO [ap_public]
    AS [dbo];

