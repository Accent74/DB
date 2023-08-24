----------------------------------------
create procedure ap_menuaction_level
@pk int,
@lvl int
as
set nocount on
update MENU_ACTIONS set MA_LEVEL = @lvl where PK=@pk


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_menuaction_level] TO [ap_public]
    AS [dbo];

