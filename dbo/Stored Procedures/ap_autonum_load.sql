----------------------------------------
create procedure ap_autonum_load
@id int
as
set nocount on
select 
  FA_ID,FA_NAME,AN_PREFIX,AN_SUFFIX,AN_CURRENT 
from
  FRM_AUTONUM 
where 
  FA_ID=@id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_autonum_load] TO [ap_public]
    AS [dbo];

