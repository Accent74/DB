----------------------------------------
create procedure app_prlist_order
@prl int
as
set nocount on
select PRC_ID, PRC_NO from PRL_PRICES where PRL_ID=@prl

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[app_prlist_order] TO [ap_public]
    AS [dbo];

