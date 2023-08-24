---------------------------------------------------------------------
create procedure ap_tree_getchild
@et int,
@px int

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

select @sql = N'select P0,P1,P2,P3,P4,P5,P6,P7,SHORTCUT from ' + @tbl + 
N' where P0=@px or P1=@px or P2=@px or P3=@px or P4=@px or P5=@px or P6=@px or P7=@px ' 

select @prm = N'@px int'

execute sp_executesql @sql, @prm, @px

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_tree_getchild] TO [ap_public]
    AS [dbo];

