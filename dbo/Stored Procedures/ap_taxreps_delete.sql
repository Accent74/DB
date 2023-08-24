----------------------------------------
create procedure dbo.ap_taxreps_delete
@id int = 0
as
set nocount on

if @id = 0
  return

If exists(select * from JRN_TAX where TX_ID=@id)
begin
  raiserror(N'Отчет удалить нельзя.\nСуществуют связанные с ним проводки.',16,-1)
  return
end

delete from TAX_REPS where TX_ID=@id

exec ap_log_add N'X',N'D',@id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_taxreps_delete] TO [ap_public]
    AS [dbo];

