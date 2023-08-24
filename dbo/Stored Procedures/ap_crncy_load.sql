----------------------------------------
create procedure ap_crncy_load 
as
set nocount on
select 
  CRC_ID, CRC_NAME, CRC_SHORT,CRC_DENOM, CRC_CODE, CRC_SPELL, CRC_FLAGS, CRC_FORMAT
from CURRENCIES


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_crncy_load] TO [ap_public]
    AS [dbo];

