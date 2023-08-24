
---------------------------------------------------------------------
create procedure ap_tree_update
@et int,
@pk int,
@id int,
@p0 int = 0,
@p1 int = 0,
@p2 int = 0,
@p3 int = 0,
@p4 int = 0,
@p5 int = 0,
@p6 int = 0,
@p7 int = 0,
@shtcut bit = 0

as
set nocount on
begin tran

declare @tbl nvarchar(32)
declare @sql nvarchar(1024)
declare @prm nvarchar(255)

exec apx_et_treename @et, @tbl OUT
if @tbl is null
  begin
    rollback tran
    raiserror (N'Недопустимое значение аргумента',16,-1)
    return 0
  end

if @pk = 0
  begin
    select @sql = N'insert into ' + @tbl + N'(ID,P0,P1,P2,P3,P4,P5,P6,P7,SHORTCUT) ' +
		  N'VALUES (@id,@p0,@p1,@p2,@p3,@p4,@p5,@p6,@p7,@shtcut)'
    select @prm = N'@id int, @p0 int, @p1 int, @p2 int, @p3 int, @p4 int, @p5 int, @p6 int, @p7 int, @shtcut bit'
    execute sp_executesql @sql, @prm, @id, @p0,@p1,@p2,@p3,@p4,@p5,@p6,@p7,@shtcut
  end
else
  begin
    select @sql = N'update ' + @tbl + N' set P0=@p0,P1=@p1,P2=@p2,P3=@p3,' +
                  N'P4=@p4,P5=@p5,P6=@p6,P7=@p7,SHORTCUT=@shtcut ' +
		  N'where PK=@pk '
    select @prm = N'@pk int, @p0 int, @p1 int, @p2 int, @p3 int, @p4 int, @p5 int, @p6 int, @p7 int, @shtcut bit'
    execute sp_executesql @sql, @prm, @pk, @p0,@p1,@p2,@p3,@p4,@p5,@p6,@p7,@shtcut
  end
commit tran

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_tree_update] TO [ap_public]
    AS [dbo];

