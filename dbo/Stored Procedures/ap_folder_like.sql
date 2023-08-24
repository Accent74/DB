----------------------------------------
create procedure ap_folder_like
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
  FLD_ID, FLD_NAME, FLD_TAG, TML_ID, FRM_ID
from 
  FOLDERS
where 
  UPPER(FLD_NAME) Like UPPER(@str)
else
select top 101
  FLD_ID, FLD_NAME, FLD_TAG, TML_ID, FRM_ID
from 
  FOLDERS
where 
  UPPER(FLD_TAG) Like UPPER(@str)


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_folder_like] TO [ap_public]
    AS [dbo];

