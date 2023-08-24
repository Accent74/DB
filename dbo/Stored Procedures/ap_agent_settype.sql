----------------------------------------
create procedure ap_agent_settype
@id int,
@type smallint
as
set nocount on
update AGENTS set AG_TYPE=@type where AG_ID=@id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_agent_settype] TO [ap_public]
    AS [dbo];

