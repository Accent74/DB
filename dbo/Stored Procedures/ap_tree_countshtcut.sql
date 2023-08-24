
---------------------------------------------------------------------

create procedure ap_tree_countshtcut
@et int,
@p0 int = 0,
@p1 int = 0,
@p2 int = 0,
@p3 int = 0,
@p4 int = 0,
@p5 int = 0,
@p6 int = 0,
@p7 int = 0
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

select @sql = N'select count(*) from ' + @tbl + N' where SHORTCUT <> 0 and ' +
	      N'(P0=@p0 or P1=@p1 or P2=@p2 or P3=@p3 or ' +
	      N'P4=@p4 or P5=@p5 OR P6=@p6 OR P7=@p7)'

select @prm = N'@p0 int, @p1 int, @p2 int, @p3 int, @p4 int, @p5 int, @p6 int, @p7 int'

execute sp_executesql @sql, @prm, @p0,@p1,@p2,@p3,@p4,@p5,@p6,@p7


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_tree_countshtcut] TO [ap_public]
    AS [dbo];

