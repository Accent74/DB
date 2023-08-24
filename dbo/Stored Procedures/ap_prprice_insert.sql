-----------------------------------------
create procedure ap_prprice_insert
@prl int,
@prc int
as
-- returns PK,NO
set nocount on

declare @no int
declare @id int

begin tran

select @no = max(PRC_NO) from PRL_PRICES where PRL_ID=@prl
if @no is null
  select @no = 1
else
  select @no = @no + 1
insert into PRL_PRICES (PRL_ID,PRC_ID,PRC_NO) values (@prl,@prc,@no)
select @id = ident_current('PRL_PRICES')
commit tran
select @id, @no

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_prprice_insert] TO [ap_public]
    AS [dbo];

