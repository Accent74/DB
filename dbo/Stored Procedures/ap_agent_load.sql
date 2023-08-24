----------------------------------------
create procedure ap_agent_load 
@id int
as
set nocount on
select 
  AG_ID, AG_NAME, AG_TAG, AG_MEMO, AG_TYPE,
  AG_CODE, AG_ADDRESS, AG_PHONE,
  AG_VATNO, AG_REGNO, AG_TABNO, AG_PASSPORT, AG_DATE1, AG_DATE2,
  AG_CONTACT, AG_COUNTRY, AG_EMAIL, AG_WWW, AG_GUID 
from
  AGENTS
where 
  AG_ID = @id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_agent_load] TO [ap_public]
    AS [dbo];

