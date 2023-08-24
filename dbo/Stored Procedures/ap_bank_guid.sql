------------------------------------------------------
create procedure ap_bank_guid 
@guid uniqueidentifier
as
set nocount on

declare @id int

select @id = BANK_ID from BANKS where BANK_GUID=@guid

if @id is null
  select @id = 0

return @id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_bank_guid] TO [ap_public]
    AS [dbo];

