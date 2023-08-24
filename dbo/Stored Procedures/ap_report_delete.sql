---------------------------------------------------------------------
create procedure ap_report_delete
@id int
as
set nocount on
begin tran
delete from REPORTS where REP_ID=@id
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_report_delete] TO [ap_public]
    AS [dbo];

