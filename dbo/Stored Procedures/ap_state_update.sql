-----------------------------------------
create procedure ap_state_update
@id int,
@name nvarchar(255),
@tag nvarchar(255),
@flag int
as
set nocount on
declare @max int
declare @res int
if @id = 0 
begin
  -- insert new
  select @max = max(ST_NO) + 1 from STATES
  insert into STATES (ST_NAME,ST_TAG,ST_NO,ST_FLAGS) values (@name,@tag,@max,@flag)
  select @res = ident_current('STATES')
  select @res, @max
end 
else
begin
  -- update
  update STATES set ST_NAME=@name, ST_TAG=@tag, ST_FLAGS=@flag where ST_ID=@id
  select ST_ID,ST_NO from STATES where ST_ID=@id
end

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_state_update] TO [ap_public]
    AS [dbo];

