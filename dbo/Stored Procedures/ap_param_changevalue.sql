---------------------------------------------------------------------
create procedure ap_param_changevalue

@et int,
@pid int,
@nid int,
@lng int,
@dbl float,
@dat datetime,
@cy money,
@str nvarchar(256)

as
set nocount on
begin tran

declare @tbl nvarchar(64)
declare @fld nvarchar(32)
declare @sql nvarchar(255)
declare @prm nvarchar(255)
declare @exists int

exec apx_et_paramvalue @et, @tbl OUT, @fld OUT
if @tbl is null or @fld is null
  begin
    rollback tran
    raiserror (N'Недопустимый тип параметра',16,-1)
    return 0
  end

exec ap_param_exists @et, @pid, @nid, @exists out

if @exists = 1 
  begin
   select @sql = N'update ' + 
	      @tbl + 
	      N' set PRM_LONG=@lng, PRM_DOUBLE=@dbl, PRM_DATE=@dat, PRM_CY=@cy, PRM_STRING=@str ' +
	      N' where PRM_ID = @pid and ' +
	      @fld +
	      N'=@nid'

    select @prm = N'@pid int, @nid int, @lng int, @dbl float, @dat datetime, @cy money, @str nvarchar(256)'
    execute sp_executesql @sql, @prm, @pid, @nid, @lng, @dbl, @dat, @cy, @str
  end
else
  begin
   select @sql = N'insert into ' + 
	      @tbl + 
	      N' (PRM_LONG, PRM_DOUBLE, PRM_DATE, PRM_CY, PRM_STRING, PRM_ID, ' + @fld +
              N' ) values (@lng,@dbl,@dat,@cy,@str,@pid,@nid) '

    select @prm = N'@pid int, @nid int, @lng int, @dbl float, @dat datetime, @cy money, @str nvarchar(256)'
    execute sp_executesql @sql, @prm, @pid, @nid, @lng, @dbl, @dat, @cy, @str
  end
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_param_changevalue] TO [ap_public]
    AS [dbo];

