----------------------------------------
create procedure ap_misc_types 
as
set nocount on
select MSC_ID,MISC.MSC_NO,MSC_NAME,MSC_REF,MSC_REFID,MISC_ATTR.MSC_FLAGS
from MISC inner join MISC_ATTR on MISC.MSC_NO = MISC_ATTR.MSC_NO
where MSC_TYPE=-1 
order by MISC.MSC_NO


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_misc_types] TO [ap_public]
    AS [dbo];

