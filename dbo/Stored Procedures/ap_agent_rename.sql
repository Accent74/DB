----------------------------------------
create procedure ap_agent_rename 
@id int, @name nvarchar(256)
as
set nocount on
begin tran
update AGENTS set AG_NAME=@name where AG_ID=@id
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_agent_rename] TO [ap_public]
    AS [dbo];

