------------------------------------------------------
create procedure ap_template_guid 
@guid uniqueidentifier
as
set nocount on

declare @id int

select @id = TML_ID from TEMPLATES where TML_GUID=@guid

if @id is null
  select @id = 0

return @id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_template_guid] TO [ap_public]
    AS [dbo];

