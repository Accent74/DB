---------------------------------------------------------------------
create procedure ap_tree_countchild
@et int,
@id int,
@p0 int = 0

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

select @sql = N'select count(*) from ' + @tbl + N' where ID=@id and P0=@p0'
select @prm = N'@id int, @p0 int'
execute sp_executesql @sql, @prm, @id, @p0


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_tree_countchild] TO [ap_public]
    AS [dbo];

