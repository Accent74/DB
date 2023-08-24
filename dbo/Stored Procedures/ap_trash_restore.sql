---------------------------------------------------------------------
CREATE procedure ap_trash_restore
@id int
as

set nocount on
begin tran
-- documents
if (select DOC_DONE from DOCUMENTS where DOC_ID=@id) < 100
  begin
    rollback tran
    raiserror (N'Ошибка при восстановлении операции',16,-1)
    return 0
  end
update DOCUMENTS set DOC_DONE=DOC_DONE-100 where DOC_ID=@id
-- transactions
update JOURNAL set J_DONE=J_DONE-100 where DOC_ID=@id
exec ap_log_add N'D',N'R',@id
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_trash_restore] TO [ap_public]
    AS [dbo];

