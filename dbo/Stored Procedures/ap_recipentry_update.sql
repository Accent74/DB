----------------------------------------
create procedure ap_recipentry_update
@id int,
@rp int,
@ent int,
@qty money,
@pct money = null,
@tag nvarchar(256) = null,
@ag int = null
as
set nocount on
declare @res int
if @id = 0
-- new item
begin
  insert into RP_CONTENTS(RP_ID,ENT_ID,RC_QTY,RC_PERCENT,RC_TAG,AG_ID) 
  values (@rp, @ent, @qty, @pct, @tag, @ag)
  select @res = ident_current('RP_CONTENTS')
end
else
-- update item
begin
  update RP_CONTENTS set 
    ENT_ID=@ent, RC_QTY=@qty, RC_PERCENT=@pct, RC_TAG=@tag, AG_ID=@ag
  where RC_ID=@id
  select @res = @id
end
return @res

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_recipentry_update] TO [ap_public]
    AS [dbo];

