--------------------------------------------
create procedure ap_binder_save
@id int,
@name nvarchar(256),
@tag nvarchar(51) = null,
@memo nvarchar(256) = null

as

set nocount on

begin tran
update BINDERS set BIND_NAME=@name,BIND_TAG=@tag,BIND_MEMO=@memo
where BIND_ID=@id
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_binder_save] TO [ap_public]
    AS [dbo];

