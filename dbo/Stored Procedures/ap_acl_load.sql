----------------------------------------
create procedure dbo.ap_acl_load
@kind int = 0
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
  -- @usr is administrator, returns empty recordset
  select null,null,null,null,null where 1<>1 
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
  if @kind = 0 or @kind is null
    select UID, KIND, EL_ID,MASK1, MASK2 from ACL where UID in (select * from #tmpt)
  else 
    select UID, KIND, EL_ID,MASK1, MASK2 from ACL where KIND=@kind and UID in (select * from #tmpt)
end

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_acl_load] TO [ap_public]
    AS [dbo];

