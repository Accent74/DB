----------------------------------------
create procedure ap_agent_params
@id int,
@type smallint = 0
as

set nocount on
-- возвращает все ID, имена и типы параметров и только нужные значения
select 
  AG_ID,PRM_ID, PRM_LONG,PRM_STRING,PRM_DOUBLE,PRM_DATE,PRM_CY
into 
  #tmp1 
from 
  AG_PARAMS where AG_ID=@id
 
select 
  #tmp1.AG_ID,
  AG_PARAM_NAMES.PRM_ID, 
  AG_PARAM_NAMES.PRM_NAME,
  AG_PARAM_NAMES.PRM_TYPE,
  AG_PARAM_NAMES.PRM_REF,
  AG_PARAM_NAMES.PRM_REFID,
  #tmp1.PRM_LONG, #tmp1.PRM_STRING,#tmp1.PRM_DOUBLE,#tmp1.PRM_DATE,#tmp1.PRM_CY,
	AG_PARAM_NAMES.PRM_DESCR	
from 
  AG_PARAM_NAMES left join #tmp1 on AG_PARAM_NAMES.PRM_ID=#tmp1.PRM_ID
where 
  AG_PARAM_NAMES.NODE_TYPE=@type

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_agent_params] TO [ap_public]
    AS [dbo];

