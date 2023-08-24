----------------------------------------
create procedure ap_menuaction_load
as
set nocount on
select PK,MA_NO,MA_NAME,MA_FILE,MA_LEVEL
from MENU_ACTIONS 
order by MA_NO


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_menuaction_load] TO [ap_public]
    AS [dbo];

