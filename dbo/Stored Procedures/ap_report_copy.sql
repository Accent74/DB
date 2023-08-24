--------------------------------------------
create procedure ap_report_copy
@id int,
@to int
as
set nocount on
begin tran

insert into REPORTS 
  (REP_X,REP_X_ID,REP_NAME,REP_TYPE,REP_SUBTYPE,REP_PS1,REP_PS2,REP_PS3,REP_PS4,REP_PS5,REP_PS6,REP_PL1,REP_PL2,REP_PL3,REP_PL4,REP_PL5,REP_MEMO) 
select
  REP_X,@to,REP_NAME,REP_TYPE,REP_SUBTYPE,REP_PS1,REP_PS2,REP_PS3,REP_PS4,REP_PS5,REP_PS6,REP_PL1,REP_PL2,REP_PL3,REP_PL4,REP_PL5,REP_MEMO 
from REPORTS where REP_ID=@id

commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_report_copy] TO [ap_public]
    AS [dbo];

