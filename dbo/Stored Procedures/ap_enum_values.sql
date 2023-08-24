----------------------------------------
create procedure ap_enum_values
@enn int
as
set nocount on
select ENM_ID,ENM_NAME,ENM_TAG
from ENUMS
where ENN_ID=@enn
order by ENM_NAME


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_enum_values] TO [ap_public]
    AS [dbo];

