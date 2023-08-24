----------------------------------------
create procedure ap_bankacc_delete
@id int
as
set nocount on
if exists(select * from JOURNAL where J_AB1=@id or J_AB2=@id)
begin
  raiserror(N'Текущий счет удалить нельзя.\nСуществуют связанные с ним проводки.',16,-1)
  return
end
delete from AG_BANKS where AB_PK=@id

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_bankacc_delete] TO [ap_public]
    AS [dbo];

