----------------------------------------
create procedure ap_account_candelete 
@id int
as
set nocount on

/* check childs */
If exists(select * from ACC_TREE where ACC_TREE.P0=@id)
begin
  raiserror(N'Счет удалить нельзя, в нем есть вложенные',16,-1)
  return 1
end

/* check journal*/
if exists(select * from JOURNAL where ACC_DB=@id or ACC_CR=@id)
begin
  raiserror(N'Счет удалить нельзя.\nОн используется в журнале операций.',16,-1)
  return 2
end

return 0


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_account_candelete] TO [ap_public]
    AS [dbo];

