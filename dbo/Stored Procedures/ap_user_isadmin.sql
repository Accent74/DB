----------------------------------------
create procedure ap_user_isadmin
as
set nocount on
declare @usr sysname
declare @ind int
declare @ret int
select @usr = SYSTEM_USER

-- avoid domain name
select @ind = CHARINDEX(N'\',@usr)
if @ind <> 0
  select @usr = N'_' + RIGHT(@usr,LEN(@usr)-@ind)
else
  select @usr = N'_' + @usr

select @ret = case when exists
(select * from sysusers left join sysmembers on sysusers.uid = sysmembers.groupuid 
where name=N'db_accessadmin' and sysusers.issqlrole = 1 and user_name(sysmembers.memberuid) = @usr)
then 1 else 0 end
return @ret


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_user_isadmin] TO [ap_public]
    AS [dbo];

