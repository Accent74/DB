---------------------------------------
create procedure ap_misc_guid 
@guid uniqueidentifier
as
set nocount on

declare @id int

select @id = MSC_ID from MISC where MSC_GUID=@guid

if @id is null
  select @id = 0

return @id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_misc_guid] TO [ap_public]
    AS [dbo];

