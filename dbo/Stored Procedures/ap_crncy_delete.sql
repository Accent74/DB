----------------------------------------
create procedure ap_crncy_delete
@id int
as
set nocount on
begin tran
if @id = 1
  begin
    rollback tran
    raiserror(N'Вы не можете удалить базовую валюту.',16,-1)
    return
  end
if 0 < (select count(*) from JRN_CRC where CRC_ID=@id)
  begin
    rollback tran
    raiserror(N'Вы не можете удалить валюту.\nОна используется в операциях.',16,-1)
    return
  end

if 0 < (select count(*) from PRC_NAMES where CRC_ID=@id)
  begin
    rollback tran
    raiserror(N'Вы не можете удалить валюту.\nОна используется в прайс-листах.',16,-1)
    return
  end
if exists (select * from AG_BANKS where CRC_ID=@id)
  begin
    rollback tran
    raiserror(N'Вы не можете удалить валюту.\nОна используется в текущих банковских счетах.',16,-1)
    return
  end
delete from CURRENCIES where CRC_ID=@id
commit tran

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_crncy_delete] TO [ap_public]
    AS [dbo];

