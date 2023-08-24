---------------------------------------------------------------------
create procedure ap_param_exists
@et int,
@pid int,
@nid int,
@exists int output
as
set nocount on

declare @tbl nvarchar(64)
declare @fld nvarchar(32)
declare @sql nvarchar(2000)
declare @prm nvarchar(256)
declare @val int

exec apx_et_paramvalue @et, @tbl OUT, @fld OUT
if @tbl is null or @fld is null
  begin
    rollback tran
    raiserror (N'Недопустимый тип параметра',16,-1)
    return 0
  end

select @sql = N' select @val = (select count(*) from ' + @tbl + 
              N' where PRM_ID=@pid and ' + @fld + N' = @nid)'

select @prm = N'@pid int, @nid int, @val int OUT'

exec sp_executesql @sql, @prm, @pid, @nid, @val out

if @val > 0
  select @exists = 1
else
  select @exists = 0


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_param_exists] TO [ap_public]
    AS [dbo];

