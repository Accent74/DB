----------------------------------------
create procedure ap_log_cleardays
as
set nocount on
begin tran
declare @onstr nvarchar(8)
declare @days int
select @onstr = PRM_STR, @days=PRM_LONG from SYS_PARAMS where PRM_NAME=N'LOG'
if upper(@onstr) = N'ON' and @days > 0
begin
  declare @dat as datetime
  select @dat = DATEADD(day,-@days,GETDATE())
  delete from SYS_LOG where LOG_DATE < @dat
  delete from SYS_LOGDOC where LOG_DATE < @dat
end 
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_log_cleardays] TO [ap_public]
    AS [dbo];

