---------------------------------------------------------------------
create procedure ap_misc_loadattr
as

set nocount on

select MISC.MSC_ID,MISC_ATTR.MSC_NO,MISC.MSC_NAME,MISC_ATTR.MSC_VISIBLE 
from MISC inner join MISC_ATTR 
on MISC.MSC_NO = MISC_ATTR.MSC_NO
where MSC_TYPE=-1
order by MISC.MSC_NAME


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_misc_loadattr] TO [ap_public]
    AS [dbo];

