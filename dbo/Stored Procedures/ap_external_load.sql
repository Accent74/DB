----------------------------------------
create procedure ap_external_load
@type smallint,
@id int
as

set nocount on

select 
  EXT_ID, EXT_NAME, EXT_FILE, EXT_MEMO, EXT_X
from 
  EXT_DOCS 
where 
  (EXT_X=@type AND EXT_X_ID=@id) OR EXT_X=@type + 100


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_external_load] TO [ap_public]
    AS [dbo];

