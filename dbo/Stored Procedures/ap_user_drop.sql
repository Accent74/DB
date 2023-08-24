----------------------------------------
create procedure ap_user_drop
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
exec @ok = sp_dropuser @uid
if @ok = 1 -- failure
begin
  raiserror(N'Невозможно удалить пользователя',16,-1)
  return
end
-- удалить login можно только если его нет в других БД
declare @exec_stmt nvarchar(1024)
create table #dblist (dbname sysname not null, user_name sysname not null)
-- COLLECT ALL INSTANCES OF USE OF THIS LOGIN IN SYSUSERS --
declare @dbname	sysname
declare db_name_cursor scroll cursor for select name from master.dbo.sysdatabases
open db_name_cursor
fetch db_name_cursor into @dbname
while @@fetch_status >= 0
begin
  if (has_dbaccess(@dbname) = 1)
  begin
    select @exec_stmt = 'set nocount on use ' + quotename( @dbname , '[') + '
	                insert into #dblist (dbname, user_name)
			select N'+ quotename( @dbname , '''')+', name from sysusers
			where sid = suser_sid(N' + quotename( @name , '''') + ') '
    exec (@exec_stmt)
  end
  fetch db_name_cursor into @dbname
end
deallocate db_name_cursor
if not exists(select * from #dblist)
  exec @ok = sp_droplogin @name

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_user_drop] TO [ap_public]
    AS [dbo];

