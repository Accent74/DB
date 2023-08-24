----------------------------------------
create procedure ap_user_create
@name nvarchar(64),
@pwd nvarchar(255)
as
set nocount on
declare @ok smallint
declare @uid nvarchar(128)
declare @db sysname
select @db = DB_NAME()

if not exists(select * from master.dbo.syslogins where name=@name)
begin
  -- создаем login, только если его еще нет
  exec @ok = sp_addlogin @name, @pwd, @db
  if @ok = 1 -- failure
  begin
    raiserror(N'Невозможно создать login для пользователя',16,-1)
    return
  end
end
select @uid = N'_' + @name
exec @ok = sp_adduser @name, @uid, N'ap_public'
if @ok = 1 -- failure
begin
  raiserror(N'Невозможно создать пользователя для базы данных',16,-1)
  return
end


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_user_create] TO [ap_public]
    AS [dbo];

