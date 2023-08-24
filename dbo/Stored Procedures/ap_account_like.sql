--------------------------------------------
CREATE procedure ap_account_like
@fnd nvarchar(256),
@what int = 2, -- 0-name,1-tag,2-code
@mode int = 0, 
@plan int = 0
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
  N'select TOP 101 ACC_ID, ACC_TYPE, ACC_NAME, ACC_TAG, ACC_CODE, ' +
  N'ACC_S_TYPE, ACC_PLAN, ACC_PL_CODE ' +
  N'from ACCOUNTS where '

select @sql = @sql + 
  case @what
    when 0 then N'upper(ACC_NAME)'
    when 1 then N'upper(ACC_TAG)'
    when 2 then N'upper(ACC_CODE)'
  end

select @sql = @sql  + N' Like @str and ACC_TYPE <> -1'

if @plan <> 0
  select @sql = @sql + N' and ACC_PLAN=@plan'
exec sp_executesql @sql,N'@str nvarchar(256), @plan int', @str, @plan


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_account_like] TO [ap_public]
    AS [dbo];

