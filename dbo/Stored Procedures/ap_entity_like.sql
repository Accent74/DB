----------------------------------------
create procedure ap_entity_like
@fnd nvarchar(256),
@what int = 0, 
-- 0-name,1-tag,2-cat,3-nom,4-art,5-bar,6-code,
@mode int = 0,
@root int = 0
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
  N'select TOP 101 ENT_ID, ENT_TYPE, ENT_NAME, ENT_TAG, ENT_CAT, ENT_NOM, ENT_ART, ENT_BAR, ENT_CODE, ' + 
  N'P0, P1, P2, P3, P4, P5, P6, P7 ' +
  N'from ENTITIES inner join ENT_TREE on ENTITIES.ENT_ID=ENT_TREE.ID where '

select @sql = @sql + 
  case @what
    when  0 then N'upper(ENT_NAME)'
    when  1 then N'upper(ENT_TAG)'
    when  2 then N'upper(ENT_CAT)'
    when  3 then N'upper(ENT_NOM)'
    when  4 then N'upper(ENT_ART)'
    when  5 then N'upper(ENT_BAR)'
    when  6 then N'upper(ENT_CODE)'
  end

select @sql = @sql  + N' Like @str and ENT_TYPE <> 0 and ENT_TYPE <> 1 and SHORTCUT=0'

if @root <> 0
  select @sql = @sql + N' and (ID=@root or P0=@root or P1=@root or P2=@root or P3=@root or P4=@root or P5=@root or P6=@root or P7=@root)'
exec sp_executesql @sql,N'@str nvarchar(256), @root int', @str, @root

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_entity_like] TO [ap_public]
    AS [dbo];

