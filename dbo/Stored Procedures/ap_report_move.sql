--------------------------------------------
create procedure ap_report_move
@id int,
@to int
as
set nocount on
begin tran
update REPORTS set REP_X_ID=@to WHERE REP_ID=@id
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_report_move] TO [ap_public]
    AS [dbo];

