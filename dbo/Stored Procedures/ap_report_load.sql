---------------------------------------------------------------------
create procedure ap_report_load 
@x smallint,
@id int
as
select 
  REP_ID, REP_NAME, REP_MEMO, REP_TYPE, REP_X, REP_PS1 
from 
  REPORTS 
where 
  (REP_X=@x and REP_X_ID=@id) or REP_X=@x + 100

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_report_load] TO [ap_public]
    AS [dbo];

