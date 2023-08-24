-----------------------------------------
create procedure ap_agent_mycompanies
as
set nocount on

select AG_ID, AG_NAME, AG_TAG, AG_TYPE, AG_CODE
from AGENTS 
where AG_TYPE=5 order by AG_NAME

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_agent_mycompanies] TO [ap_public]
    AS [dbo];

