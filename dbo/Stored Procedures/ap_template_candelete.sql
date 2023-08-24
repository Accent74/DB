----------------------------------------
create procedure ap_template_candelete 
@id int
as
set nocount on

/* check childs */
If exists(select * from TML_TREE where TML_TREE.P0=@id)
begin
  raiserror(N'Папку удалить нельзя, в ней есть вложенные',16,-1)
  return 1
end

/* check documents*/
if exists(select * from DOCUMENTS where TML_ID=@id)
begin
  raiserror(N'Шаблон удалить нельзя.\nОн используется в журнале операций.',16,-1)
  return 2
end

/* check folders*/
if exists(select * from FOLDERS where TML_ID=@id)
begin
  raiserror(N'Шаблон удалить нельзя.\nОн используется в папках как шаблон по умолчанию.',16,-1)
  return 3
end

return 0


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_template_candelete] TO [ap_public]
    AS [dbo];

