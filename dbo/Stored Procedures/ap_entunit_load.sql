----------------------------------------
create procedure ap_entunit_load
@ent int
as
set nocount on
select EU_PK,UN_ID,EU_NO,EU_NUM,EU_DENOM 
from ENT_UNITS where ENT_ID=@ent order by EU_NO


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_entunit_load] TO [ap_public]
    AS [dbo];

