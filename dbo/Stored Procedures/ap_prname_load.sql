----------------------------------------
create procedure ap_prname_load
as 
set nocount on
select PRC_ID,PRC_NAME,CRC_ID,PRC_MEMO,PRC_TAG,UN_ID from PRC_NAMES order by PRC_NAME

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_prname_load] TO [ap_public]
    AS [dbo];

