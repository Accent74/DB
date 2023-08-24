----------------------------------------
create procedure ap_autonum_loadall
as
set nocount on
select 
  FA_ID,FA_NAME,AN_PREFIX,AN_SUFFIX,AN_CURRENT 
from
  FRM_AUTONUM 
order by 
  FA_NAME


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_autonum_loadall] TO [ap_public]
    AS [dbo];

