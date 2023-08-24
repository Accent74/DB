----------------------------------------
create procedure ap_entunit_swap
@pk1 int,
@pk2 int
as
set nocount on
begin tran
declare @no1 int
declare @no2 int
select @no1 = EU_NO from ENT_UNITS where EU_PK=@pk1
select @no2 = EU_NO from ENT_UNITS where EU_PK=@pk2
update ENT_UNITS set EU_NO=@no2 where EU_PK=@pk1
update ENT_UNITS set EU_NO=@no1 where EU_PK=@pk2
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_entunit_swap] TO [ap_public]
    AS [dbo];

