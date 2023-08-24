---------------------------------------------------------------------
create procedure ap_external_rename 
@id int, 
@name nvarchar(256)
as
set nocount on
begin tran
update EXT_DOCS set EXT_NAME=@name 
where EXT_ID=@id
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_external_rename] TO [ap_public]
    AS [dbo];

