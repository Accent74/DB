---------------------------------------------------------------------
-- переименование папки
---------------------------------------------------------------------
create procedure ap_folder_rename 
@id int, @name nvarchar(256)
as
set nocount on
begin tran
update FOLDERS set FLD_NAME=@name where FLD_ID=@id
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_folder_rename] TO [ap_public]
    AS [dbo];

