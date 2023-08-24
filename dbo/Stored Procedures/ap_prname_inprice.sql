----------------------------------------
create procedure ap_prname_inprice 
@id int
as
set nocount on
select 
  PRC_NAMES.PRC_ID, PRC_NAMES.PRC_NAME, PRC_NAMES.CRC_ID, 
  PRL_PRICES.PRLPC, PRL_PRICES.PRC_NO, PRC_NAMES.PRC_MEMO,
  PRC_NAMES.PRC_TAG, PRC_NAMES.UN_ID
from 
  PRC_NAMES inner join PRL_PRICES on PRC_NAMES.PRC_ID = PRL_PRICES.PRC_ID 
where 
  PRL_PRICES.PRL_ID=@id 
order by 
  PRL_PRICES.PRC_NO


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_prname_inprice] TO [ap_public]
    AS [dbo];

