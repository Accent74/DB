---------------------------------------------------------------------
create procedure ap_param_deletevalue
@et int,
@pid int,
@nid int
as
set nocount on
begin tran
declare @tbl nvarchar(64)
declare @fld nvarchar(32)
declare @sql nvarchar(255)
declare @prm nvarchar(255)
 
exec apx_et_paramvalue @et, @tbl OUT, @fld OUT
if @tbl is null or @fld is null
  begin
    rollback tran
    raiserror (N'Недопустимый тип параметра',16,-1)
    return 0
  end
  
select @sql = N'delete from ' + 
	      @tbl + 
	      N' where PRM_ID = @pid and ' +
	      @fld +
	      N'=@nid'

select @prm = N'@pid int, @nid int'

execute sp_executesql @sql, @prm, @pid, @nid

commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_param_deletevalue] TO [ap_public]
    AS [dbo];

