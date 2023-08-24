------------------------------------------------------
create procedure ap_account_guid 
@guid uniqueidentifier
as
set nocount on

declare @id int

select @id = ACC_ID from ACCOUNTS where ACC_GUID=@guid

if @id is null
  select @id = 0

return @id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_account_guid] TO [ap_public]
    AS [dbo];

