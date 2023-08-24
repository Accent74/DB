----------------------------------------
create procedure ap_agent_load7
@id1 int, @id2 int, @id3 int, @id4 int,
@id5 int,@id6 int,@id7 int
as
set nocount on
select 
  AGENTS.AG_ID, AGENTS.AG_NAME, AGENTS.AG_TAG, AGENTS.AG_TYPE, AGENTS.AG_CODE,
  AGENTS.AG_TABNO, AGENTS.AG_VATNO, AGENTS.AG_REGNO, AGENTS.AG_ACC_X, AGENTS.AG_DATE1, AGENTS.AG_DATE2
from 
  AGENTS 
where 
  AG_ID=@id1 or AG_ID=@id2 or AG_ID=@id3 or
  AG_ID=@id4 or AG_ID=@id5 or AG_ID=@id6 or AG_ID=@id7

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_agent_load7] TO [ap_public]
    AS [dbo];

