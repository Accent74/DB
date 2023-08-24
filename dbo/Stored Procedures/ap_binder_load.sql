--------------------------------------------
create procedure ap_binder_load
@id int
as

set nocount on

select BIND_TYPE,BIND_NAME,BIND_TAG,BIND_MEMO,BIND_GUID
from BINDERS where BIND_ID=@id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_binder_load] TO [ap_public]
    AS [dbo];

