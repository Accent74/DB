----------------------------------------
create procedure ap_sys_setmycompany
@id int
as
set nocount on

declare @prmname nvarchar(32)
select @prmname = N'MY_COMPANY'
begin tran
if (select count(*) from AGENTS where AG_ID=@id) <= 0
begin
  rollback tran
  raiserror(N'Корреспондент не существует',16,-1)
  return
end

if (select count(*) from SYS_PARAMS where PRM_NAME=@prmname) = 0
  insert into SYS_PARAMS (PRM_NAME) values (@prmname)

update SYS_PARAMS set PRM_LONG=@id where PRM_NAME=@prmname
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_sys_setmycompany] TO [ap_public]
    AS [dbo];

