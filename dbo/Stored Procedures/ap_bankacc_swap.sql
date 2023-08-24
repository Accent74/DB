----------------------------------------
create procedure ap_bankacc_swap
@pk1 int,
@pk2 int
as
set nocount on
begin tran
declare @no1 int
declare @no2 int
select @no1 = AB_NO from AG_BANKS where AB_PK=@pk1
select @no2 = AB_NO from AG_BANKS where AB_PK=@pk2
update AG_BANKS set AB_NO=@no2 where AB_PK=@pk1
update AG_BANKS set AB_NO=@no1 where AB_PK=@pk2
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_bankacc_swap] TO [ap_public]
    AS [dbo];

