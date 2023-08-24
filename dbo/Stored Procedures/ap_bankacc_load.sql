-----------------------------------------
create procedure ap_bankacc_load
@id int
as
set nocount on
select AB_PK,AB_NO,BANK_ID,AG_BANKACC,AB_MEMO, AB_TAG, ACC_ID, CRC_ID, AB_FLAGS
from AG_BANKS where AB_PK=@id

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_bankacc_load] TO [ap_public]
    AS [dbo];

