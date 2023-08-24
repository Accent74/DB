----------------------------------------
create procedure ap_binder_fordoc
@id int
as 
set nocount on

select BINDERS.BIND_ID, BINDERS.BIND_NAME, BINDERS.BIND_TAG, BINDERS.BIND_TYPE
from BINDERS inner join BIND_DOCS on BINDERS.BIND_ID = BIND_DOCS.BIND_ID 
where BIND_DOCS.DOC_ID=@id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_binder_fordoc] TO [ap_public]
    AS [dbo];

