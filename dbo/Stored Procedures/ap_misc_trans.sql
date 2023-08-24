-----------------------------------------
create procedure ap_misc_trans 
@id int
as
set nocount on
select JM_KEY, MSC_ID, MSC_NO 
from JRN_MISC 
where J_ID=@id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_misc_trans] TO [ap_public]
    AS [dbo];

