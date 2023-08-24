-----------------------------------------
create procedure ap_enumname_update
@id int,
@name nvarchar(256),
@tag nvarchar(256) = null
as
set nocount on
declare @res int
if @id = 0
-- new item
begin
  insert into ENUM_NAMES(ENN_NAME,ENN_TAG) values (@name,@tag)
  select @res = ident_current('ENUM_NAMES')
end
else
-- update item
begin
  update ENUM_NAMES set ENN_NAME=@name,ENN_TAG=@tag where ENN_ID=@id
  select @res = @id
end
return @res

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_enumname_update] TO [ap_public]
    AS [dbo];

