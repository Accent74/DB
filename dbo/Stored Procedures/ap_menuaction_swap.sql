----------------------------------------
create procedure ap_menuaction_swap
@pk1 int,
@pk2 int
as
set nocount on
begin tran
declare @no1 int
declare @no2 int
select @no1 = MA_NO from MENU_ACTIONS where PK=@pk1
select @no2 = MA_NO from MENU_ACTIONS where PK=@pk2
update MENU_ACTIONS set MA_NO=@no2 where PK=@pk1
update MENU_ACTIONS set MA_NO=@no1 where PK=@pk2
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_menuaction_swap] TO [ap_public]
    AS [dbo];

