----------------------------------------
create procedure ap_unit_update
@id int,
@short nvarchar(256),
@name nvarchar(256),
@memo nvarchar(256),
@tag nvarchar(51),
@guid uniqueidentifier = null
as
set nocount on

declare @nid int
select @nid = 0
if @id = 0
begin
  if @guid is null
  begin
    insert into UNITS (UN_SHORT,UN_NAME,UN_MEMO,UN_TAG)
    values (@short,@name,@memo,@tag)
    select @nid = ident_current('UNITS')
  end
  else
  begin
    insert into UNITS (UN_SHORT,UN_NAME,UN_MEMO,UN_TAG,UN_GUID)
    values (@short,@name,@memo,@tag,@guid)
    select @nid = ident_current('UNITS')
  end
end
else
begin
  update UNITS set UN_SHORT=@short, UN_NAME=@name,UN_MEMO=@memo,UN_TAG=@tag
    where UN_ID=@id
  select @nid = @id
end
return @nid

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_unit_update] TO [ap_public]
    AS [dbo];

