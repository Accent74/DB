----------------------------------------
create procedure ap_bank_load
@id int
as
set nocount on
select 
  BANK_ID, BANK_MFO, BANK_NAME, BANK_CITY,
  BANK_COUNTRY, BANK_MEMO, BANK_CORRACC, BANK_CORRID, BANK_GUID
from 
  BANKS
where
  BANK_ID=@id

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_bank_load] TO [ap_public]
    AS [dbo];

