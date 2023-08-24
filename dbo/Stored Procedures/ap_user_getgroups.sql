----------------------------------------
create procedure ap_user_getgroups
as
set nocount on
declare @usr sysname
declare @ind int
declare @isadm int
select @usr = SYSTEM_USER

-- avoid domain name
select @ind = CHARINDEX(N'\',@usr)
if @ind <> 0
  select @usr = N'_' + RIGHT(@usr,LEN(@usr)-@ind)
else
  select @usr = N'_' + @usr

select @isadm = case when exists
(select * from sysusers left join sysmembers on sysusers.uid = sysmembers.groupuid 
where name=N'db_accessadmin' and sysusers.issqlrole = 1 and user_name(sysmembers.memberuid) = @usr)
then 1 else 0 end

if @isadm = 1
begin
  -- @usr is administrator, returns all groups
  select cast(name as nvarchar(128)) as nm into #tmp1 from sysusers where issqlrole = 1 and uid=gid and name<>N'ap_public' and name<>N'public' 
    and substring(name,1,1)=N'_'
  insert into #tmp1 (nm) values (N'_Admins')
  insert into #tmp1 (nm) values (N'_Users')
  select nm, cast(1 as int) from #tmp1
end
else
begin
  -- @usr not admin -> select groups for him
  select cast(name as nvarchar(128)) as nm into #tmp2 from sysusers left join sysmembers on sysusers.uid = sysmembers.groupuid 
    where name<>N'db_accessadmin' and name<>N'ap_public' and sysusers.issqlrole = 1 and user_name(sysmembers.memberuid) = @usr
  insert into #tmp2 (nm) values (N'_Users')
  select nm, cast(0 as int) from #tmp2
end


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_user_getgroups] TO [ap_public]
    AS [dbo];

