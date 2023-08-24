-----------------------------------------
create procedure ap_prname_update
@id int,
@crc int,
@name nvarchar(256),
@memo nvarchar(256) = null,
@tag nvarchar(256) = null,
@un int = null
as
set nocount on
begin tran
declare @resid int
select @resid = @id
if @id = 0
  begin
    -- insert new
    insert into PRC_NAMES (PRC_NAME,CRC_ID,PRC_MEMO,PRC_TAG,UN_ID) values (@name,@crc,@memo,@tag,@un)
    select @resid = ident_current('PRC_NAMES')
  end
else
  update PRC_NAMES set PRC_NAME=@name,PRC_MEMO=@memo,PRC_TAG=@tag,UN_ID=@un WHERE PRC_ID=@id
commit tran
return @resid

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_prname_update] TO [ap_public]
    AS [dbo];

