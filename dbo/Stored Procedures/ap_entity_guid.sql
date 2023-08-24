------------------------------------------------------
create procedure ap_entity_guid 
@guid uniqueidentifier
as
set nocount on

declare @id int

select @id = ENT_ID from ENTITIES where ENT_GUID=@guid

if @id is null
  select @id = 0

return @id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_entity_guid] TO [ap_public]
    AS [dbo];

