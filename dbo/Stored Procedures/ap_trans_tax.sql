----------------------------------------
create procedure dbo.ap_trans_tax
@pk  int,
@jid int,
@tx int,
@addr1 nvarchar(256) = null,
@addr2 nvarchar(256) = null,
@sgn int = null
as
set nocount on

-- пусто, если строки равны null & sgn = 0
if @pk = 0 and (@addr1 is not null or @addr2 is not null or @sgn is not null)
  begin
    -- insert new record
    insert into JRN_TAX (J_ID,TX_ID,JT_ADDR1, JT_ADDR2, JT_SIGN) values (@jid,@tx,@addr1,@addr2,@sgn)
  end
else if @pk <> 0 and @addr1 is null and @addr2 is null and @sgn is null
  begin
    -- delete record
    delete from JRN_TAX where JT_KEY=@pk
  end
else if @pk <> 0
  begin
    -- update record
    update JRN_TAX set JT_ADDR1=@addr1, JT_ADDR2=@addr2, JT_SIGN=@sgn where JT_KEY=@pk
  end

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_trans_tax] TO [ap_public]
    AS [dbo];

