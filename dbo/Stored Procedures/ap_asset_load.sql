----------------------------------------
create procedure ap_asset_load
@id int
as
select 
AST_IN_DATE, AST_IN_ACT_NO, AST_IN_ACT_DATE, AST_MANUFACT, AST_MANUF_DATE,
AST_PASSPORT, AST_REG_NO, AST_DEPREC_CODE, AST_DEPREC_PERCENT, AST_OUT_DATE, 
AST_OUT_ACT_NO, AST_OUT_ACT_DATE, AST_USEFUL_LIFE, 
AST_OUT_REASON 
from ENT_ASSETS where ENT_ID=@id



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_asset_load] TO [ap_public]
    AS [dbo];

