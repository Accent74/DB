----------------------------------------
create procedure ap_form_candelete 
@id int
as
set nocount on

/* check documents */
If exists(select * from DOCUMENTS where FRM_ID=@id)
begin
  raiserror(N'Форму удалить нельзя, поскольку есть операции,\nв которых она используется',16,-1)
  return 1
end

/* check templates*/
if exists(select * from TEMPLATES where FRM_ID=@id)
begin
  raiserror(N'Форму удалить нельзя, поскольку есть шаблоны,\nв которых она используется',16,-1)
  return 2
end

if exists(select * from FOLDERS where FRM_ID=@id)
begin
  raiserror(N'Форму удалить нельзя, поскольку есть папки,\nк которым она подключена',16,-1)
  return 3
end

return 0


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_form_candelete] TO [ap_public]
    AS [dbo];

