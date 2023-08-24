----------------------------------------
create procedure ap_rate_update
@id int,
@crc int,
@rt int,
@dt datetime,
@val money
as
set nocount on
declare @resid int
begin tran
if @id = 0
  begin
    -- insert
    insert into CRC_RATES (CRC_ID, RT_ID, RT_DATE, RT_NUM)
        values (@crc,@rt,@dt,@val)
    select @resid = ident_current('CRC_RATES')
  end 
else
  begin
    -- update
    update CRC_RATES set RT_DATE=@dt, RT_NUM=@val WHERE PK=@id
    select @resid = @id  
  end
commit tran
return @resid

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_rate_update] TO [ap_public]
    AS [dbo];

