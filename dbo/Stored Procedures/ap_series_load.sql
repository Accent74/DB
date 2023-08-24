----------------------------------------
create procedure ap_series_load
@id int
as
select SER_ID, SER_NAME, SER_TAG, SER_MEMO, SER_NUMBER, SER_CODE, 
SER_DATE1, SER_DATE2, SER_CY1, SER_CY2, SER_LONG1, ENT_ID
from SERIES where SER_ID=@id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_series_load] TO [ap_public]
    AS [dbo];

