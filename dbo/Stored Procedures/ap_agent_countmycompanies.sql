-----------------------------------------
create procedure ap_agent_countmycompanies
as
set nocount on
select count(*) from AGENTS where AG_TYPE=5

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_agent_countmycompanies] TO [ap_public]
    AS [dbo];

