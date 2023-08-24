----------------------------------------
create procedure ap_autonum_update
@id int,
@name nvarchar(51),
@prefix nvarchar(51) = null,
@suffix nvarchar(51) = null,
@current int = null
as
set nocount on

declare @res int

begin tran

if @id = 0
begin
  -- new autonum
  insert into FRM_AUTONUM (FA_NAME,AN_PREFIX,AN_SUFFIX,AN_CURRENT) 
    values (@name,@prefix,@suffix,@current) 
  select @res = ident_current('FRM_AUTONUM')
end
else
begin 
  -- edit autonum
  update FRM_AUTONUM set FA_NAME=@name, AN_PREFIX=@prefix, AN_SUFFIX=@suffix, AN_CURRENT=@current 
  where FA_ID=@id
  select @res = @id
end
commit tran
return @res

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_autonum_update] TO [ap_public]
    AS [dbo];

