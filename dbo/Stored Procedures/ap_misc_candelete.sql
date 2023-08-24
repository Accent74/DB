-----------------------------------------
create procedure ap_misc_candelete 
@id int
as
set nocount on
/* check childs */
If exists(select * from MISC_TREE where MISC_TREE.P0=@id)
begin
  raiserror(N'Аналитику удалить нельзя, в ней есть вложенные',16,-1)
  return 1
end
/* check journal*/
declare @no int
select @no = MSC_NO from MISC where MSC_ID=@id
if exists(select * from JRN_MISC where MSC_ID=@id and MSC_NO=@no)
begin
  raiserror(N'Аналитику удалить нельзя.\nОна используется в журнале операций.',16,-1)
  return 2
end
/* check misc references */
if exists(select * from MISC inner join JRN_MISC on MISC.MSC_NO = JRN_MISC.MSC_NO where MISC.MSC_TYPE=-1 and MISC.MSC_ID=@id)
begin
  raiserror(N'Аналитику удалить нельзя.\nОна используется в журнале операций.',16,-1)
  return 2
end
return 0

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_misc_candelete] TO [ap_public]
    AS [dbo];

