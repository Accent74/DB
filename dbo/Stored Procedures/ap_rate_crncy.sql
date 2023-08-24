----------------------------------------
create procedure ap_rate_crncy 
@crc int,
@rt int,
@dt datetime
as
set nocount on
select CRC_RATES.PK, CRC_RATES.RT_NUM, CRC_RATES.RT_DATE 
from CRC_RATES 
where CRC_RATES.CRC_ID=@crc and CRC_RATES.RT_ID=@rt and CRC_RATES.RT_DATE>=@dt
order by CRC_RATES.RT_DATE desc


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_rate_crncy] TO [ap_public]
    AS [dbo];

