------------------------------------------------------
create procedure ap_operation_guid 
@guid uniqueidentifier
as
set nocount on

declare @id int

select @id = DOC_ID from DOCUMENTS where DOC_GUID=@guid

if @id is null
  select @id = 0

return @id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_operation_guid] TO [ap_public]
    AS [dbo];

