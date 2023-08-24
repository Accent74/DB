----------------------------------------
create procedure ap_rtname_update
@id int,
@name nvarchar(256),
@memo nvarchar(256) = null,
@flags int = null
as
set nocount on
declare @resid int
begin tran
if @flags is null
  select @flags = 0
if @flags <> 0
  update CRC_RT_NAMES set RT_FLAGS=null
if @id = 0
  begin
    -- insert
    insert into CRC_RT_NAMES (RT_NAME,RT_MEMO,RT_FLAGS)
       values (@name,@memo,@flags)
    select @resid = ident_current('CRC_RT_NAMES')
  end 
else
  begin
    -- update
    update CRC_RT_NAMES set RT_NAME=@name, RT_MEMO=@memo, RT_FLAGS=@flags
    where RT_ID=@id
    select @resid = @id
  end
commit tran
return @resid

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_rtname_update] TO [ap_public]
    AS [dbo];

