---------------------------------------------------------------------
create procedure ap_prlist_load
as
set nocount on
select PRL_ID,PRL_NAME,PRL_MEMO,PRL_FLAGS from PRL_LISTS


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_prlist_load] TO [ap_public]
    AS [dbo];

