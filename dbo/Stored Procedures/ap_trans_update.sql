-----------------------------------------
create procedure ap_trans_update
@jid int,
@docid int,
@trno smallint,
@lnno smallint,
@date datetime,
@db int,
@cr int,
@ag1 int,
@ag2 int,
@ent int,
@sum money,
@qty money,
@price money,
@un int = null,
@unf int = null,
@fqty money = 0,
@lnk int = null,
@ser int = null,
@pd int = null,
@changes int = null,
@done int = 0,
@jab1 int = null,
@jab2 int = null,
@jtag nvarchar(16) = null
as

set nocount on
declare @id int
if @jid = 0
  begin
    insert into JOURNAL 
      (J_DONE,DOC_ID,J_TR_NO,J_LN_NO,J_DATE, ACC_DB,ACC_CR,J_AG1,J_AG2,J_ENT,J_SUM,
       J_QTY,J_PRICE,J_UN,JF_UN,JF_QTY,J_LINK,SER_ID,PDOC_ID,J_AB1,J_AB2,J_TAG)
    values
      (@done,@docid,@trno,@lnno,@date,@db,@cr,@ag1,@ag2,@ent,@sum,@qty,@price,@un,@unf,@fqty,@lnk,@ser,@pd,@jab1,@jab2,@jtag)
    select @id = ident_current('JOURNAL')
  end
else
  begin
    update JOURNAL set
      J_TR_NO=@trno,J_LN_NO=@lnno,J_DATE=@date, ACC_DB=@db,ACC_CR=@cr,
      J_AG1=@ag1,J_AG2=@ag2,J_ENT=@ent,J_SUM=@sum,J_QTY=@qty,J_PRICE=@price,
      J_UN=@un,JF_UN=@unf,JF_QTY=@fqty,J_LINK=@lnk,SER_ID=@ser,PDOC_ID=@pd,
      J_AB1=@jab1, J_AB2=@jab2, J_TAG=@jtag
    where J_ID=@jid
    exec ap_logdoc_add 1, 0, @jid, @changes
    select @id = @jid
  end
return @id

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_trans_update] TO [ap_public]
    AS [dbo];

