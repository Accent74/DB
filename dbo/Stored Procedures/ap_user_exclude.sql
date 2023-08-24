----------------------------------------
create procedure ap_user_exclude
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
  exec sp_droprolemember N'db_accessadmin',@ua
end
else
begin
  exec sp_droprolemember @ga, @ua
end


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_user_exclude] TO [ap_public]
    AS [dbo];

