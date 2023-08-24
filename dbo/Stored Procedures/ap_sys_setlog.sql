----------------------------------------
create procedure ap_sys_setlog
@on int,
@days int,
@ext int
as 
set nocount on
declare @stron nvarchar(8)
declare @strdoc nvarchar(8)
begin tran
if @on = 1
  select @stron = N'On'
else
  select @stron = null
if @ext = 1
  select @strdoc = N'On'
else
  select @strdoc = null
if (select count(*) from SYS_PARAMS where PRM_NAME=N'LOG') = 0
  insert into SYS_PARAMS (PRM_NAME) values (N'LOG')
if (select count(*) from SYS_PARAMS where PRM_NAME=N'LOGDOC') = 0
  insert into SYS_PARAMS (PRM_NAME) values (N'LOGDOC')
update SYS_PARAMS set PRM_STR=@stron, PRM_LONG=@days where PRM_NAME=N'LOG'
update SYS_PARAMS set PRM_STR=@strdoc where PRM_NAME=N'LOGDOC'
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_sys_setlog] TO [ap_public]
    AS [dbo];

