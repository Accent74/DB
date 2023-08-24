----------------------------------------
create procedure ap_user_include
@user nvarchar(128),
@group nvarchar(128)
as
set nocount on
declare @ua sysname
declare @ga sysname
select @ua = N'_' + @user
select @ga = N'_' + @group
if @group = N'Admins'
begin
  -- grant to db_accessadmin
  exec sp_addrolemember N'db_accessadmin',@ua
end
else
begin
  exec sp_addrolemember @ga, @ua
end


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_user_include] TO [ap_public]
    AS [dbo];

