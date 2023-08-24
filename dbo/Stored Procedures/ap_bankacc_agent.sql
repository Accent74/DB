-----------------------------------------
create procedure ap_bankacc_agent
@id int
as
set nocount on
select AB_PK,AB_NO,BANK_ID,AG_BANKACC,AB_MEMO,AB_TAG,ACC_ID,CRC_ID,AB_FLAGS
from AG_BANKS where AG_ID=@id order by AB_NO

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_bankacc_agent] TO [ap_public]
    AS [dbo];

