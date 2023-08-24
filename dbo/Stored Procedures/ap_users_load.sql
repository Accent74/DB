----------------------------------------
create procedure ap_users_load
as
set nocount on
select sysusers.name, sysusers.uid, sysmembers.memberuid, user_name(sysmembers.memberuid) as usrname
from sysusers left join sysmembers on sysusers.uid = sysmembers.groupuid 
where (left(name,1)=N'_' or name=N'ap_public' or name=N'db_accessadmin')and 
sysusers.issqlrole = 1 order by sysusers.uid


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_users_load] TO [ap_public]
    AS [dbo];

