---------------------------------------------------------------------
create procedure ap_trans_loadcy 
@id int
as
set nocount on
select 
  JC_KEY,CRC_ID,RT_ID,JC_NO,JC_SUM,JC_PRICE,JC_RATE 
from
  JRN_CRC 
where 
  J_ID=@id
order by 
  JC_NO


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_trans_loadcy] TO [ap_public]
    AS [dbo];

