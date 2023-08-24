----------------------------------------
create procedure ap_enum_update
@id int,
@enn int,
@name nvarchar(256),
@tag nvarchar(256) = null
as
set nocount on
declare @res int
if @id = 0
-- new item
begin
  insert into ENUMS(ENN_ID,ENM_NAME,ENM_TAG) values (@enn,@name,@tag)
  select @res = ident_current('ENUMS')
end
else
-- update item
begin
  update ENUMS set ENM_NAME=@name, ENM_TAG=@tag where ENM_ID=@id
  select @res = @id
end
return @res

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_enum_update] TO [ap_public]
    AS [dbo];

