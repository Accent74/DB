
---------------------------------------------------------------------
create procedure ap_tree_delete
@et int,
@id int,
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

select @sql = N'delete from ' + @tbl +
              N' where ID=@id and P0=@p0 and P1=@p1 and P2=@p2 and P3=@p3 and ' +
              N' P4=@p4 and P5=@p5 and P6=@p6 and P7=@p7'
select @prm = N'@id int, @p0 int, @p1 int, @p2 int, @p3 int, @p4 int, @p5 int, @p6 int, @p7 int'
execute sp_executesql @sql, @prm, @id, @p0, @p1, @p2, @p3, @p4, @p5, @p6, @p7
commit tran



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_tree_delete] TO [ap_public]
    AS [dbo];

