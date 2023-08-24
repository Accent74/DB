----------------------------------------
create procedure ap_state_delete 
@id int
as
set nocount on

/* check DOCUMENTS */
if exists(select * from DOCUMENTS where ST_ID=@id)
begin
  raiserror(N'Состояние удалить нельзя, поскольку существуют связанные операции',16,-1)
  return 1
end
else
begin
  delete from STATES where ST_ID=@id
end


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_state_delete] TO [ap_public]
    AS [dbo];

