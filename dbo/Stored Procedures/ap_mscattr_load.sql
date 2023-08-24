----------------------------------------
create procedure ap_mscattr_load
@no int
as

set nocount on
select 
  MSC_VISIBLE,MS1_NAME,MS2_NAME,MS3_NAME,
  ML1_NAME,ML2_NAME,ML3_NAME,ML1_TYPE,ML2_TYPE,ML3_TYPE,
  MC1_NAME,MC2_NAME,MC3_NAME,MD1_NAME,MD2_NAME,MD3_NAME,
  MSC_FLAGS 
from
  MISC_ATTR WHERE MSC_NO=@no


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_mscattr_load] TO [ap_public]
    AS [dbo];

