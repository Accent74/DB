-----------------------------------------
create procedure ap_prname_delete
@id int
as
set nocount on
delete from PRC_NAMES where PRC_ID=@id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_prname_delete] TO [ap_public]
    AS [dbo];

