---------------------------------------------------------------------
create procedure ap_param_deletename
@et int,
@id int
as
set nocount on
begin tran
declare @tbl nvarchar(64)
declare @sql nvarchar(255)
declare @prm nvarchar(255)
 
exec apx_et_paramname @et, @tbl OUT
if @tbl is null
  begin
    rollback tran
    raiserror (N'Недопустимый тип параметра',16,-1)
    return 0
  end
  
select @sql = N'DELETE FROM ' + 
	      @tbl + 
	      N' WHERE PRM_ID = @id'

select @prm = N'@id int'

execute sp_executesql @sql, @prm, @id

commit tran



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_param_deletename] TO [ap_public]
    AS [dbo];

