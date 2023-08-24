---------------------------------------------------------------------
create procedure ap_entity_candelete 
@id int
as
set nocount on

/* check childs */
If exists(select * from ENT_TREE where ENT_TREE.P0=@id)
begin
  raiserror(N'Объект учета или папку удалить нельзя, в нем есть вложенные',16,-1)
  return 1
end

/* check journal*/
if exists(select * from JOURNAL where J_ENT=@id)
begin
  raiserror(N'Объект учета удалить нельзя.\nОн используется в журнале операций.',16,-1)
  return 2
end

/* check references*/
if exists(select * from MISC inner join JRN_MISC on MISC.MSC_NO = JRN_MISC.MSC_NO where MISC.MSC_TYPE=-1 and MISC.MSC_REF=2 AND JRN_MISC.MSC_ID=@id)
begin
  raiserror(N'Объект учета удалить нельзя.\nНа него есть ссылки в произвольной аналитике.',16,-1)
  return 3
end

return 0


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_entity_candelete] TO [ap_public]
    AS [dbo];

