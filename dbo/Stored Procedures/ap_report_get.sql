--------------------------------------------
create procedure ap_report_get
@id int
as
select 
  REP_ID, REP_NAME, REP_MEMO, REP_TYPE, REP_X, REP_X_ID,
  REP_PS1, REP_PS2, REP_PS3, REP_PS4, REP_PS5, REP_PS6,
  REP_PL1, REP_PL2, REP_PL3, REP_PL4, REP_PL5
from 
  REPORTS 
where 
  REP_ID=@id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_report_get] TO [ap_public]
    AS [dbo];

