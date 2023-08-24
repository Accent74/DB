-----------------------------------------
create procedure ap_bankacc_save
@pk int,
@ag int,
@bank int,
@no int,
@acc nvarchar(255),
@memo nvarchar(255),
@tag nvarchar(51) = null,
@accid int = null,
@crc int = null,
@flags int = null
as

set nocount on

begin tran

declare @id int
select @id = 0

if @pk = 0
  begin
    if @no = 0 or @no is null
      if exists(select * from AG_BANKS where AG_ID=@ag)
      	select @no=(max(AB_NO) + 1) from AG_BANKS where AG_ID=@ag
      else
        select @no = 1
    insert into AG_BANKS (AB_NO,AG_ID,BANK_ID,AG_BANKACC,AB_MEMO,AB_TAG,ACC_ID,CRC_ID,AB_FLAGS) 
    values (@no,@ag,@bank,@acc,@memo,@tag,@accid,@crc,@flags)
    select @id = ident_current('AG_BANKS')
  end
else
  begin
    update AG_BANKS set BANK_ID=@bank, AG_BANKACC = @acc, AB_NO = @no, AB_MEMO = @memo,
           AB_TAG = @tag, ACC_ID=@accid, CRC_ID=@crc, AB_FLAGS=@flags
    where AB_PK = @pk
  end

commit tran
return @id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_bankacc_save] TO [ap_public]
    AS [dbo];

