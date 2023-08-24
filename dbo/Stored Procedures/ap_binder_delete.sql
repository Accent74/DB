----------------------------------------
create procedure ap_binder_delete
@id int
as
set nocount on
begin tran
delete from BINDERS where BIND_ID=@id
exec ap_log_add N'B',N'D',@id
commit


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_binder_delete] TO [ap_public]
    AS [dbo];

