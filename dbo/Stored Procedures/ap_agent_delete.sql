---------------------------------------------------------------------
create procedure ap_agent_delete
@id int
as
set nocount on
begin tran
delete from AGENTS where AG_ID=@id
exec ap_log_add N'G',N'D',@id
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_agent_delete] TO [ap_public]
    AS [dbo];

