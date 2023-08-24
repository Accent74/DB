---------------------------------------------------------------------
create procedure ap_document_rename 
@id int, @name nvarchar(256)
as
set nocount on
begin tran
update DOCUMENTS set DOC_NAME=@name where DOC_ID=@id
-- write to log
exec ap_log_add N'D',N'U',@id
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_document_rename] TO [ap_public]
    AS [dbo];

