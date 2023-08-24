----------------------------------------
create procedure ap_entunit_update
@pk int,
@ent int,
@un int,
@no int,
@num money,
@denom money
as
set nocount on
begin tran
declare @nn int
declare @id int
if @pk = 0
  begin
    -- insert
    select @nn = max(EU_NO) from ENT_UNITS where ENT_ID=@ent
    if @nn is null
      select @nn = 1
    else
      select @nn = @nn + 1
    insert into ENT_UNITS (ENT_ID,UN_ID,EU_NO,EU_NUM,EU_DENOM)
      values (@ent,@un,@nn,@num,@denom)
    select @id = ident_current('ENT_UNITS')
  end
else
  begin
    -- update
    update ENT_UNITS set UN_ID=@un, EU_NUM=@num, EU_DENOM=@denom WHERE EU_PK=@pk
    select @id = @pk
    select @nn = @no
  end
commit tran
select @id, @nn

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_entunit_update] TO [ap_public]
    AS [dbo];

