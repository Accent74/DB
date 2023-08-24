----------------------------------------------
create procedure ap_folder_delete
@id int
as
set nocount on
begin tran
delete from FOLDERS where FLD_ID=@id
exec ap_log_add N'F',N'D',@id
commit


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_folder_delete] TO [ap_public]
    AS [dbo];

