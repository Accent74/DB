----------------------------------------
create procedure ap_enum_names
as
set nocount on
select ENN_ID,ENN_NAME,ENN_TAG,
case when exists(select * from ENUMS as E where ENUM_NAMES.ENN_ID=E.ENN_ID) then 1 else 0 end 
from ENUM_NAMES
order by ENN_NAME


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_enum_names] TO [ap_public]
    AS [dbo];

