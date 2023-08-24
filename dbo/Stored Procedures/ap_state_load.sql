----------------------------------------
create procedure ap_state_load
as

set nocount on
select ST_ID, ST_NAME, ST_TAG, ST_FLAGS, ST_NO 
from STATES order by ST_NO


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_state_load] TO [ap_public]
    AS [dbo];

