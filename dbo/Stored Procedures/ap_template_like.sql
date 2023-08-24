----------------------------------------
create procedure ap_template_like
@fnd nvarchar(256),
@mode int = 0,
@design bit = 0
as
set nocount on
declare @str nvarchar(256)

if @mode = 0 -- вхождение
  select @str = N'%' + @fnd + N'%'
else if @mode = 1 -- начиная с
  select @str = @fnd + N'%'
else if @mode = 2 -- полное совпадение
  select @str = @fnd

if @design = 1
	select top 101
  	TML_ID, TML_TYPE, TML_NAME, TML_TAG, TML_MEMO 
	from 
  	TEMPLATES 
	where 
  	UPPER(TML_NAME) Like UPPER(@str) AND TML_TYPE<>0
else
	select top 101
  	TML_ID, TML_TYPE, TML_NAME, TML_TAG, TML_MEMO 
	from 
  	TEMPLATES 
	where 
  	TML_HIDDEN=0 and UPPER(TML_NAME) Like UPPER(@str) AND TML_TYPE<>0

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_template_like] TO [ap_public]
    AS [dbo];

