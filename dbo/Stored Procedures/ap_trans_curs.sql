----------------------------------------
create procedure ap_trans_curs
@pk  int,
@jid int,
@crc int,
@rt int,
@no int,
@sum money,
@price money,
@rate money
as
set nocount on

if @pk = 0 and @crc <> 0
  begin
    -- insert new record
    insert into JRN_CRC (J_ID,CRC_ID,JC_NO,JC_SUM,JC_PRICE,JC_RATE) 
       values (@jid,@crc,@no,@sum,@price,@rate)
  end
else if @pk <> 0 and @crc = 0
  begin
    -- delete record
    delete from JRN_CRC where JC_KEY=@pk
  end
else if @pk <> 0 and @crc <> 0
  begin
    -- update record
    update JRN_CRC set CRC_ID=@crc, RT_ID=@rt, JC_NO=@no,
           JC_SUM = @sum, JC_PRICE=@price, JC_RATE=@rate
    where JC_KEY=@pk
  end


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_trans_curs] TO [ap_public]
    AS [dbo];

