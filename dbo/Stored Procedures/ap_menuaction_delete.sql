----------------------------------------
create procedure ap_menuaction_delete
@pk int
as
set nocount on
delete from MENU_ACTIONS where PK=@pk


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_menuaction_delete] TO [ap_public]
    AS [dbo];

