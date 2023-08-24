----------------------------------------
create procedure ap_folder_candelete 
@id int
as
set nocount on

/* check childs */
If exists(select * from FLD_TREE where FLD_TREE.P0=@id)
begin
  raiserror(N'Папку удалить нельзя, в ней есть вложенные',16,-1)
  return 1
end

/* check documents*/
if exists(select * from DOCUMENTS where FLD_ID=@id)
begin
  raiserror(N'Папку удалить нельзя.\nВ ней есть документы или операции.',16,-1)
  return 2
end

/* check forms*/
if exists(select * from FORMS where FORMS.FLD_ID=@id)
begin
  raiserror(N'Папку удалить нельзя.\nОна связана с формами.',16,-1)
  return 3
end

return 0

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_folder_candelete] TO [ap_public]
    AS [dbo];

