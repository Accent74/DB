----------------------------------------
create procedure ap_state_rights
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

--if @isadm <> 1
begin
  -- first result set
  select ST_ID, ST_FLAGS from STATE_FLAGS where UID = @usr
  -- second result set
  select ST_FROM, ST_TO from STATE_WALK where UID = @usr
end


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_state_rights] TO [ap_public]
    AS [dbo];

