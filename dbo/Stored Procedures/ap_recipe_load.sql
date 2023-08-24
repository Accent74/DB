----------------------------------------
create procedure ap_recipe_load
@id int
as

set nocount on

select 
  RP_ID,ENT_ID,RP_NAME,RP_TAG,RP_MEMO,RP_DATE1,RP_DATE2,RP_QTY,
  RP_LONG1,RP_LONG2,RP_FLAGS
from RECIPES where RP_ID=@id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_recipe_load] TO [ap_public]
    AS [dbo];

