---------------------------------------------------------------------
create procedure ap_repfav_load 
@x smallint,
@id int
as
select 
  REP_ID, REP_NAME, REP_MEMO, REP_TYPE, REP_X, REP_PS1 
from 
  REPORTS 
where 
	REP_ID in (select F_REF from FAVORITES WHERE F_PARENT=@id)

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_repfav_load] TO [ap_public]
    AS [dbo];

