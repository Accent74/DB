----------------------------------------
create procedure ap_series_set
@id1 int = null,
@id2 int = null,
@id3 int = null,
@id4 int = null,
@id5 int = null,
@id6 int = null,
@id7 int = null
as
select SER_ID, SER_NAME, SER_TAG, SER_MEMO, SER_NUMBER, SER_CODE, 
SER_DATE1, SER_DATE2, SER_CY1, SER_CY2, SER_LONG1, ENT_ID
from SERIES where SER_ID=@id1 or SER_ID=@id2 or SER_ID=@id3 or SER_ID=@id4
or SER_ID=@id5 or SER_ID=@id6 or SER_ID=@id7


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_series_set] TO [ap_public]
    AS [dbo];

