---------------------------------------------------------------------
create procedure ap_trans_misc
@pk  int,
@jid int,
@msc int,
@no  int
as
set nocount on

if @pk = 0 and @msc <> 0
  begin
    -- insert new record
    insert into JRN_MISC (J_ID,MSC_ID,MSC_NO) values (@jid,@msc,@no)
  end
else if @pk <> 0 and @msc = 0
  begin
    -- delete record
    delete from JRN_MISC where JM_KEY=@pk
  end
else if @pk <> 0 and @msc <> 0
  begin
    -- update record
    update JRN_MISC set MSC_ID=@msc, MSC_NO=@no where JM_KEY=@pk
  end



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_trans_misc] TO [ap_public]
    AS [dbo];

