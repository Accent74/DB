----------------------------------------
create procedure ap_recipe_update
@id int,
@ent int,
@name nvarchar(256),
@tag nvarchar(256) = null,
@memo nvarchar(256) = null,
@date1 datetime = null,
@date2 datetime = null,
@qty money = null,
@long1 int = null,
@long2 int = null,
@flags int = null
as
set nocount on
declare @res int
if @id = 0
-- new item
begin
  insert into RECIPES(ENT_ID,RP_NAME,RP_TAG,RP_MEMO,RP_DATE1,RP_DATE2,RP_QTY,RP_LONG1,RP_LONG2,RP_FLAGS) 
  values (@ent,@name,@tag,@memo,@date1,@date2,@qty,@long1,@long2,@flags)
  select @res = ident_current('RECIPES')
end
else
-- update item
begin
  update RECIPES set 
    RP_NAME=@name, RP_TAG=@tag, RP_MEMO=@memo, RP_DATE1=@date1, RP_DATE2=@date2,
    RP_QTY=@qty, RP_LONG1=@long1, RP_LONG2=@long2, RP_FLAGS=@flags        
  where RP_ID=@id
  select @res = @id
end
return @res

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_recipe_update] TO [ap_public]
    AS [dbo];

