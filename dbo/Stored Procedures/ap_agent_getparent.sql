----------------------------------------
create procedure ap_agent_getparent 
@id int
as
  set nocount on
select P0 from AG_TREE where SHORTCUT=0 AND ID=@id

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_agent_getparent] TO [ap_public]
    AS [dbo];

