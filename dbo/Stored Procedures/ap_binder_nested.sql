----------------------------------------
create procedure ap_binder_nested
@id int
as 
set nocount on

select BINDERS.BIND_ID, BINDERS.BIND_NAME, BINDERS.BIND_TAG, BINDERS.BIND_TYPE
from BINDERS inner join BIND_TREE on BINDERS.BIND_ID = BIND_TREE.ID 
where P0=@id or P1=@id or P2=@id or P3=@id or P4=@id or P5=@id or P6=@id or P7=@id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_binder_nested] TO [ap_public]
    AS [dbo];

