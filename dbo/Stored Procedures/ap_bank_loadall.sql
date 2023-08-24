----------------------------------------
create procedure ap_bank_loadall
as
set nocount on
select 
  BANK_ID, BANK_MFO, BANK_NAME, BANK_CITY,
  BANK_COUNTRY, BANK_MEMO, BANK_CORRACC, BANK_CORRID, BANK_GUID
from BANKS


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_bank_loadall] TO [ap_public]
    AS [dbo];

