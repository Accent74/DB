----------------------------------------
create procedure ap_group_drop
@name nvarchar(64)
as
set nocount on
declare @uid nvarchar(128)
declare @ok smallint
select @uid = N'_' + @name
begin tran
delete from RIGHTS where UID=@uid
delete from ACL where UID=@uid
commit tran
exec @ok = sp_droprole @uid
if @ok = 1 -- failure
begin
  raiserror(N'Невозможно удалить группу',16,-1)
  return
end

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_group_drop] TO [ap_public]
    AS [dbo];

