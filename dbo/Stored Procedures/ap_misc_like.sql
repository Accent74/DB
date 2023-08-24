----------------------------------------
create procedure ap_misc_like
@root int,
@fnd nvarchar(256),
@what int, -- 0-name, 1-tag
@mode int = 0,
@no int = 0
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
  N'select TOP 101 MSC_ID, MSC_TYPE, MSC_NAME, MSC_TAG, MSC_NO ' +
  N'from MISC where '

select @sql = @sql + 
  case @what
    when  0 then N'upper(MSC_NAME)'
    when  1 then N'upper(MSC_TAG)'
    else N'upper(MSC_NAME)'
  end

select @sql = @sql  + N' Like @str and MSC_TYPE <> -1 and MSC_TYPE <> 0 '

if @root <> 0 -- сначала корень, он имеет приоритет
  select @sql = @sql + N'and MSC_ID in (select ID from MISC_TREE where ID=@root or P0=@root or P1=@root or P2=@root or P3=@root or P4=@root or P5=@root or P6=@root or P7=@root)'
else if @no <> 0
  select @sql = @sql + N'and MSC_NO=@no'

exec sp_executesql @sql,N'@str nvarchar(256), @root int, @no int', @str, @root, @no


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_misc_like] TO [ap_public]
    AS [dbo];

