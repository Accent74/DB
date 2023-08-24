----------------------------------------
create procedure ap_rtname_load
as
set nocount on
select RT_ID,RT_NAME,RT_MEMO,RT_FLAGS from CRC_RT_NAMES order by RT_NAME


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_rtname_load] TO [ap_public]
    AS [dbo];

