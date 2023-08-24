------------------------------------------------------
create procedure ap_unit_guid 
@guid uniqueidentifier
as
set nocount on

declare @id int

select @id = UN_ID from UNITS where UN_GUID=@guid

if @id is null
  select @id = 0

return @id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_unit_guid] TO [ap_public]
    AS [dbo];

