-------------------------------------------
create procedure ap_usrprm_set
@name nvarchar(256),
@type smallint,
@str nvarchar(256),
@cy money,
@lng int,
@dt datetime
as
set nocount on
begin tran
if (@str is null and @cy is null and @lng is null and @dt is null) or (@type = 1)
begin
  -- delete
  delete from USR_PARAMS where PRM_NAME=@name
end
else 
begin
  if exists(select * from USR_PARAMS where PRM_NAME=@name)
  begin
    -- update
    update USR_PARAMS set PRM_STRING=@str, PRM_CY=@cy, PRM_LONG=@lng, PRM_DATE=@dt
    where PRM_NAME=@name
  end
  else
  begin
    -- insert
    insert into USR_PARAMS (PRM_NAME, PRM_TYPE, PRM_STRING, PRM_CY, PRM_LONG, PRM_DATE)
	values (@name,@type,@str,@cy,@lng,@dt)
  end
end
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_usrprm_set] TO [ap_public]
    AS [dbo];

