----------------------------------------
create procedure ap_state_flag
@cmd int,
@id  int,
@uname nvarchar(255),
@prm int
as
set nocount on

declare @uid nvarchar(255)
select @uid = N'_' + @uname

if @cmd = 1 -- get flags
begin
  select ST_FLAGS from STATE_FLAGS where ST_ID=@id and UID=@uid
end
else if @cmd = 2 -- set flags
begin
  if not exists (select * from STATE_FLAGS where ST_ID=@id and UID=@uid)
    begin
      if @prm <> 0
        insert into STATE_FLAGS (ST_FLAGS,ST_ID,UID) values (@prm, @id, @uid)
    end
  else
    begin
      if @prm = 0
        delete from STATE_FLAGS where ST_ID= @id and UID=@uid
      else
        update STATE_FLAGS set ST_FLAGS=@prm where ST_ID= @id and UID=@uid
    end   
  select ST_FLAGS from STATE_FLAGS where  ST_ID=@id and UID=@uid
end
else if @cmd = 3 -- get next states
begin
  select ST_TO from STATE_WALK where ST_FROM=@id and UID=@uid
end
else if @cmd = 5 -- add next state
begin
  if not exists (select * from STATE_WALK where ST_FROM=@id and ST_TO=@prm and UID=@uid)
    insert into STATE_WALK (ST_FROM, ST_TO, UID) values (@id, @prm, @uid)	
  select cast(0 as int)
end
else if @cmd = 6 -- delete next
begin
  delete from STATE_WALK where ST_FROM=@id and ST_TO=@prm and UID=@uid
  select cast(0 as int)
end


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_state_flag] TO [ap_public]
    AS [dbo];

