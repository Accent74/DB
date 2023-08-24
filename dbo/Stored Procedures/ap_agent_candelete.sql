-----------------------------------------
create procedure ap_agent_candelete 
@id int
as
set nocount on
If exists(select * from AG_TREE where AG_TREE.P0=@id)
begin
  raiserror(N'Корреспондента или папку удалить нельзя, в нем есть вложенные',16,-1)
  return 1
end
if exists(select * from JOURNAL where J_AG1=@id or J_AG2=@id or MC_ID=@id)
begin
  raiserror(N'Корреспондента удалить нельзя.\nОн используется в журнале операций.',16,-1)
  return 2
end
if exists(select * from DOCUMENTS where MC_ID=@id)
begin
  raiserror(N'Корреспондента удалить нельзя.\nОн используется в журнале операций.',16,-1)
  return 2
end
/* check references*/
if exists(select * from MISC inner join JRN_MISC on MISC.MSC_NO = JRN_MISC.MSC_NO where MISC.MSC_TYPE=-1 and MISC.MSC_REF=1 and JRN_MISC.MSC_ID=@id)
begin
  raiserror(N'Корреспондента удалить нельзя.\nНа него есть ссылки в произвольной аналитике.',16,-1)
  return 3
end

return 0

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_agent_candelete] TO [ap_public]
    AS [dbo];

