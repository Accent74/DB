----------------------------------------
create procedure ap_agent_nested
@id int
as
set nocount on
select 
  AG_ID,AG_TYPE,AG_NAME,AG_TAG,AG_CODE,AG_TABNO,AG_VATNO, AG_ACC_X, AG_DATE1, AG_DATE2, AG_TREE.P0
from 
  AGENTS inner join AG_TREE on AGENTS.AG_ID=AG_TREE.ID
where 
  P0=@id or P1=@id or P2=@id or P3=@id or P4=@id or P5=@id or P6=@id or P7=@id

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_agent_nested] TO [ap_public]
    AS [dbo];

