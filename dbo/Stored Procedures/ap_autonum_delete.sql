----------------------------------------
create procedure ap_autonum_delete 
@id int
as
set nocount on

begin tran
/* check forms */
If exists(select * from FORMS where FA_ID=@id)
begin
  rollback tran
  raiserror(N'Элемент автонумерации удалить нельзя, поскольку\nесть формы, в которых он используется',16,-1)
  return
end
delete from FRM_AUTONUM where FA_ID=@id
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_autonum_delete] TO [ap_public]
    AS [dbo];

