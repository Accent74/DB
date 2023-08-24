----------------------------------------
create procedure ap_log_clearnow
as
set nocount on
begin tran
declare @onstr nvarchar(8)
select @onstr = PRM_STR from SYS_PARAMS where PRM_NAME=N'LOG'
if upper(@onstr) = N'ON'
begin
  delete from SYS_LOG
  delete from SYS_LOGDOC
end 
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_log_clearnow] TO [ap_public]
    AS [dbo];

