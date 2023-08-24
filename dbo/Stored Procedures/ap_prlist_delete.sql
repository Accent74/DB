-----------------------------------------
create procedure ap_prlist_delete
@id int
as
set nocount on
delete from PRL_LISTS where PRL_ID=@id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_prlist_delete] TO [ap_public]
    AS [dbo];

