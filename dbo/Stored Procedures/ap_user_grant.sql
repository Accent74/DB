----------------------------------------
create procedure ap_user_grant
@name nvarchar(64),
@domain nvarchar(64)
as
set nocount on
declare @ok smallint
declare @uid nvarchar(255)
declare @db sysname
declare @fn nvarchar(255)

select @db = DB_NAME()
select @fn = @domain + N'\' + @name


if not exists(select * from master.dbo.syslogins where name=@fn)
begin
  -- создаем login, только если его еще нет
  exec @ok = sp_grantlogin @fn
  if @ok = 1 -- failure
  begin
    raiserror(N'Невозможно разрешить login для пользователя',16,-1)
    return
  end
end
select @uid = N'_' + @name
exec @ok = sp_adduser @fn, @uid, N'ap_public'
if @ok = 1 -- failure
begin
  raiserror(N'Невозможно создать пользователя для базы данных',16,-1)
  return
end


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_user_grant] TO [ap_public]
    AS [dbo];

