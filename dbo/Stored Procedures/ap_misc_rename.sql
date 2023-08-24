---------------------------------------------------------------------
create procedure ap_misc_rename 
@id int, @name nvarchar(256)
as
set nocount on
begin tran
update MISC set MSC_NAME=@name where MSC_ID=@id
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_misc_rename] TO [ap_public]
    AS [dbo];

