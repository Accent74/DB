---------------------------------------------------------------------
create procedure ap_param_rename
@et int,
@id int,
@name nvarchar(256)
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
    raiserror (N'Недопустимый тип элемента',16,-1)
    return 0
  end
  
select @sql = N'UPDATE ' + 
	      @tbl + 
              N' SET PRM_NAME = @name' +
	      N' WHERE PRM_ID = @id'

select @prm = N'@id int, @name nvarchar(256)'

execute sp_executesql @sql, @prm, @id, @name

commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_param_rename] TO [ap_public]
    AS [dbo];

