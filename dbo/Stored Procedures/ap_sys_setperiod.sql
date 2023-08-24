----------------------------------------
create procedure ap_sys_setperiod
@start datetime,
@end datetime
as
set nocount on

declare @pstart nvarchar(32)
declare @pend nvarchar(32)
select @pstart = N'START_DATE'
select @pend   = N'END_DATE'

begin tran

if (select count(*) from SYS_PARAMS where PRM_NAME=@pstart) = 0
  insert into SYS_PARAMS (PRM_NAME) values (@pstart)
if (select count(*) from SYS_PARAMS where PRM_NAME=@pend) = 0
  insert into SYS_PARAMS (PRM_NAME) values (@pend)

update SYS_PARAMS set PRM_DATE=@start where PRM_NAME=@pstart
update SYS_PARAMS set PRM_DATE=@end where PRM_NAME=@pend

commit tran

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_sys_setperiod] TO [ap_public]
    AS [dbo];

