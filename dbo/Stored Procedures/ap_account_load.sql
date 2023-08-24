--------------------------------------------
create procedure ap_account_load
@id int
as
set nocount on
select ACC_TYPE,ACC_NAME,ACC_TAG,ACC_MEMO,ACC_CODE,ACC_T_TYPE,ACC_S_TYPE,ACC_GUID
from ACCOUNTS 
where ACC_ID=@id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_account_load] TO [ap_public]
    AS [dbo];

