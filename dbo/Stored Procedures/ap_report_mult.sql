----------------------------------------
create procedure ap_report_mult
@id int
as
set nocount on
begin tran
declare @type smallint
select @type = REP_X from REPORTS where REP_ID=@id
if @type < 100
  begin
    update REPORTS set REP_X = REP_X + 100 where REP_ID=@id
  end
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_report_mult] TO [ap_public]
    AS [dbo];

