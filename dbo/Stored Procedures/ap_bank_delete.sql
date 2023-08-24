----------------------------------------
create procedure ap_bank_delete
@id int
as
set nocount on
begin tran
if exists(select * from AG_BANKS where BANK_ID=@id)
  begin
    rollback tran
    raiserror(N'Нельзя удалить банк, поскольку есть\nкорреспонденты со счетами в этом банке',16,-1)
    return
  end
if exists(select * from BANKS where BANK_CORRID=@id)
  begin
    rollback tran
    raiserror(N'Нельзя удалить банк, поскольку есть\nбанки с корр. счетами в этом банке',16,-1)
    return
  end

delete from BANKS where BANK_ID=@id
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_bank_delete] TO [ap_public]
    AS [dbo];

