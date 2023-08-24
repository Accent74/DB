--------------------------------------------
create procedure ap_agent_like
@fnd nvarchar(256),
@what int = 2, 
-- 0-name,1-tag,2-code,3-vatno,4-regno,5-tabno,6-phone,
-- 7-addr, 8-email, 9-www, 10-contact,11-country,12-passp
@mode int = 0
as
set nocount on
declare @str nvarchar(256)
declare @sql nvarchar(4000)

if @mode = 0 -- вхождение
  select @str = N'%' + @fnd + N'%'
else if @mode = 1 -- начиная с
  select @str = @fnd + N'%'
else if @mode = 2 -- полное совпадение
  select @str = @fnd

select @str = upper(@str)

select @sql = 
  N'select TOP 101 AG_ID, AG_TYPE, AG_NAME, AG_TAG, AG_CODE, ' +
  N'P0, P1, P2, P3, P4, P5, P6, P7 ' +
  N'from AGENTS inner join AG_TREE on AGENTS.AG_ID=AG_TREE.ID where '

select @sql = @sql + 
  case @what
    when  0 then N'upper(AG_NAME)'
    when  1 then N'upper(AG_TAG)'
    when  2 then N'upper(AG_CODE)'
    when  3 then N'upper(AG_VATNO)'
    when  4 then N'upper(AG_REGNO)'
    when  5 then N'upper(AG_TABNO)'
    when  6 then N'upper(AG_PHONE)'
    when  7 then N'upper(AG_ADDRESS)'
    when  8 then N'upper(AG_EMAIL)'
    when  9 then N'upper(AG_WWW)'
    when 10 then N'upper(AG_CONTACT)'
    when 11 then N'upper(AG_COUNTRY)'
    when 12 then N'upper(AG_PASSPORT)'
  end
select @sql = @sql  + N' Like @str and AG_TYPE <> 0 and AG_TREE.SHORTCUT=0'
execute sp_executesql @sql,N'@str nvarchar(256)', @str

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_agent_like] TO [ap_public]
    AS [dbo];

