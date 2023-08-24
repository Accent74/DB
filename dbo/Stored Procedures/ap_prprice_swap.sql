---------------------------------------------------------------------
create procedure ap_prprice_swap
@pk1 int,
@pk2 int
as
set nocount on
begin tran
declare @no1 int
declare @no2 int
select @no1 = PRC_NO from PRL_PRICES where PRLPC=@pk1
select @no2 = PRC_NO from PRL_PRICES where PRLPC=@pk2
update PRL_PRICES set PRC_NO=@no2 where PRLPC=@pk1
update PRL_PRICES set PRC_NO=@no1 where PRLPC=@pk2
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_prprice_swap] TO [ap_public]
    AS [dbo];

