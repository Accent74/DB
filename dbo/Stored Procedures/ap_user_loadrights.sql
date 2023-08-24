----------------------------------------
create procedure ap_user_loadrights
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
  -- @usr is administrator, returns disables only
  select KIND,KINDID,FLAGS from RIGHTS where KIND=-5 and UID=@usr
end
else
begin
  -- @usr not admin -> select groups for him
  select name as group_name into #tmpt from sysusers left join sysmembers on sysusers.uid = sysmembers.groupuid 
    where name<>N'db_accessadmin' and name<>N'ap_public' and sysusers.issqlrole = 1 and user_name(sysmembers.memberuid) = @usr
  -- already in Users group
  insert into #tmpt (group_name) values (N'_Users')
  -- and user_name
  insert into #tmpt (group_name) values (@usr)
  select KIND,KINDID,FLAGS from RIGHTS where UID in (select * from #tmpt)
end


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_user_loadrights] TO [ap_public]
    AS [dbo];

