----------------------------------------
create procedure ap_binder_like
@fnd nvarchar(256),
@what int = 0, 
-- 0-name,1-tag,
@mode int = 0
as
set nocount on
declare @str nvarchar(256)

if @mode = 0 -- вхождение
  select @str = N'%' + @fnd + N'%'
else if @mode = 1 -- начиная с
  select @str = @fnd + N'%'
else if @mode = 2 -- полное совпадение
  select @str = @fnd

if @what = 0
select top 101
  BIND_ID, BIND_NAME, BIND_TAG, BIND_TYPE
from 
  BINDERS
where 
  UPPER(BIND_NAME) Like UPPER(@str) and BIND_TYPE <> 0
else
select top 101
  BIND_ID, BIND_NAME, BIND_TAG, BIND_TYPE
from 
  BINDERS
where 
  UPPER(BIND_TAG) Like UPPER(@str) and BIND_TYPE <> 0


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_binder_like] TO [ap_public]
    AS [dbo];

