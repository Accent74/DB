
---------------------------------------------------------------------
create procedure ap_tree_load
@et int,
@id int = 0
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

select @sql = N'select PK, ID, P0, P1, P2, P3, P4, P5, P6, P7, SHORTCUT from ' + 
              @tbl + N' where ' +
	      N'P0=@id or P1=@id or P2=@id or P3=@id or ' +
	      N'P4=@id or P5=@id or P6=@id or P7=@id'

select @prm = N'@id int'

execute sp_executesql @sql, @prm, @id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_tree_load] TO [ap_public]
    AS [dbo];

