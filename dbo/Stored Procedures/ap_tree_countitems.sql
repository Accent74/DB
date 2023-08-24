
---------------------------------------------------------------------
create procedure ap_tree_countitems
@et int,
@id int
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

select @sql = N'select count(*) from ' + @tbl + N' where ID=@id'
select @prm = N'@id int'
execute sp_executesql @sql, @prm, @id



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_tree_countitems] TO [ap_public]
    AS [dbo];

