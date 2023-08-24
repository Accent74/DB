---------------------------------------------------------------------
create procedure ap_tree_path
@et int,
@id int
as
set nocount on

declare @tbl nvarchar(32)
declare @sql nvarchar(255)
declare @prm nvarchar(255)

exec apx_et_treename @et, @tbl OUT
if @tbl is null
  begin
    raiserror (N'Недопустимое значение аргумента',16,-1)
    return 0
  end

select @sql = N'select P0,P1,P2,P3,P4,P5,P6,P7 from ' +
	      @tbl  + N' where ID=@id and SHORTCUT=0'
select @prm = N'@id int'

execute sp_executesql @sql, @prm, @id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_tree_path] TO [ap_public]
    AS [dbo];

