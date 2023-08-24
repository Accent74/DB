------------------------------------------------------
create procedure ap_binder_guid 
@guid uniqueidentifier
as
set nocount on

declare @id int

select @id = BIND_ID from BINDERS where BIND_GUID=@guid

if @id is null
  select @id = 0

return @id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_binder_guid] TO [ap_public]
    AS [dbo];

