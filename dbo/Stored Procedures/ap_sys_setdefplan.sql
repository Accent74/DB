----------------------------------------
create procedure ap_sys_setdefplan
@id int
as
set nocount on

declare @prmname nvarchar(32)
select @prmname = N'DEFAULT_PLAN'
begin tran
if (select count(*) from SYS_PARAMS where PRM_NAME=@prmname) = 0
  insert into SYS_PARAMS (PRM_NAME) values (@prmname)

update SYS_PARAMS set PRM_LONG=@id where PRM_NAME=@prmname
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_sys_setdefplan] TO [ap_public]
    AS [dbo];

