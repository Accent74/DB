----------------------------------------
create procedure ap_series_delete
@id int
as
set nocount on
begin tran
delete from SERIES where SER_ID=@id
commit


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_series_delete] TO [ap_public]
    AS [dbo];

