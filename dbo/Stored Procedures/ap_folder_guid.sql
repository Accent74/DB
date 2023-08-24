------------------------------------------------------
create procedure ap_folder_guid 
@guid uniqueidentifier
as
set nocount on

declare @id int

select @id = FLD_ID from FOLDERS where FLD_GUID=@guid

if @id is null
  select @id = 0

return @id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_folder_guid] TO [ap_public]
    AS [dbo];

