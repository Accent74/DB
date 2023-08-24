---------------------------------------------------------------------
create procedure ap_trash_remove
@id int
as
set nocount on
declare @guid uniqueidentifier
begin tran
select @guid = DOC_GUID from DOCUMENTS where DOC_ID=@id
delete from DOCUMENTS where DOC_ID=@id
exec ap_log_add N'D','M',@id, null, null, null, null, @guid
commit tran

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_trash_remove] TO [ap_public]
    AS [dbo];

