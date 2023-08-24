---------------------------------------------------------------------
create procedure ap_price_history
@prc int,
@ent int,
@prl int
as
set nocount on
select 
  PK, PRC_DATE, PRC_VALUE 
from PRC_CONTENTS 
where 
  PRC_ID=@prc AND ENT_ID=@ent AND PRL_ID=@prl
order by PRC_DATE desc


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_price_history] TO [ap_public]
    AS [dbo];

