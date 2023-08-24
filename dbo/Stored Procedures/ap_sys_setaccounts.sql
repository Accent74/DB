----------------------------------------
create procedure ap_sys_setaccounts
@bank nvarchar(256),
@cash nvarchar(256)
as
set nocount on

declare @pbank nvarchar(32)
declare @pcash nvarchar(32)
select @pbank = N'BANK_ACC'
select @pcash = N'CASH_ACC'

begin tran

if (select count(*) from SYS_PARAMS where PRM_NAME=@pbank) = 0
  insert into SYS_PARAMS (PRM_NAME) values (@pbank)

if (select count(*) from SYS_PARAMS where PRM_NAME=@pcash) = 0
  insert into SYS_PARAMS (PRM_NAME) values (@pcash)

update SYS_PARAMS set PRM_STR=@bank where PRM_NAME=@pbank
update SYS_PARAMS set PRM_STR=@cash where PRM_NAME=@pcash

commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_sys_setaccounts] TO [ap_public]
    AS [dbo];

