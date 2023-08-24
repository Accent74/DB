------------------------------------------------------
create procedure ap_agent_guid 
@guid uniqueidentifier
as
set nocount on

declare @id int

select @id = AG_ID from AGENTS where AG_GUID=@guid

if @id is null
  select @id = 0

return @id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_agent_guid] TO [ap_public]
    AS [dbo];

