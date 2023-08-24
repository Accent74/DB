----------------------------------------
create procedure ap_prlist_setdefault
@id int
as
set nocount on

begin tran
update PRL_LISTS set PRL_FLAGS=null
update PRL_LISTS set PRL_FLAGS=1 where PRL_ID=@id
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_prlist_setdefault] TO [ap_public]
    AS [dbo];

