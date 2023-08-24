----------------------------------------
create procedure ap_sys_settitles
@title nvarchar(256)
as
set nocount on

declare @ptitle nvarchar(32)
select @ptitle = N'DOC_TITLES'

begin tran

if (select count(*) from SYS_PARAMS where PRM_NAME=@ptitle) = 0
  insert into SYS_PARAMS (PRM_NAME) values (@ptitle)

update SYS_PARAMS set PRM_STR=@title where PRM_NAME=@ptitle

commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_sys_settitles] TO [ap_public]
    AS [dbo];

