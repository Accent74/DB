
---------------------------------------------------------------------
create procedure ap_tree_haschildren
@et int,
@p0 int

as
set nocount on

declare @tbl nvarchar(32)
declare @sql nvarchar(1024)
declare @prm nvarchar(255)

exec apx_et_treename @et, @tbl OUT
if @tbl is null
  begin
    raiserror (N'Недопустимое значение аргумента',16,-1)
    return 0
  end

select @sql = N'select count(*) from ' + @tbl + N' where P0=@p0' 
select @prm = N'@p0 int'

execute sp_executesql @sql, @prm, @p0



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_tree_haschildren] TO [ap_public]
    AS [dbo];

