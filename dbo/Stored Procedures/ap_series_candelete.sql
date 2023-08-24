---------------------------------------------------------------------
create procedure ap_series_candelete 
@id int
as
set nocount on

/* check journal*/
if exists(select * from JOURNAL where SER_ID=@id)
begin
  raiserror(N'Партию удалить нельзя.\nОна используется в журнале операций.',16,-1)
  return 1
end

return 0


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_series_candelete] TO [ap_public]
    AS [dbo];

