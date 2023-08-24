-----------------------------------------
create procedure ap_agent_firstmycompany
as
set nocount on
select top 1  AG_ID from AGENTS where AG_TYPE=5

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_agent_firstmycompany] TO [ap_public]
    AS [dbo];

