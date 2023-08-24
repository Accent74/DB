----------------------------------------
create procedure ap_entity_params
@id int,
@type smallint = 0
as

set nocount on
-- возвращает все ID, имена и типы параметров и только нужные значения
select 
  ENT_ID,PRM_ID, PRM_LONG,PRM_STRING,PRM_DOUBLE,PRM_DATE,PRM_CY
into 
  #tmp1 
from 
  ENT_PARAMS where ENT_ID=@id
 
select 
  #tmp1.ENT_ID,
  ENT_PARAM_NAMES.PRM_ID, 
  ENT_PARAM_NAMES.PRM_NAME,
  ENT_PARAM_NAMES.PRM_TYPE,
  ENT_PARAM_NAMES.PRM_REF,
  ENT_PARAM_NAMES.PRM_REFID,
  #tmp1.PRM_LONG, #tmp1.PRM_STRING,#tmp1.PRM_DOUBLE,#tmp1.PRM_DATE,#tmp1.PRM_CY,
	ENT_PARAM_NAMES.PRM_DESCR	
from 
  ENT_PARAM_NAMES left join #tmp1 on ENT_PARAM_NAMES.PRM_ID=#tmp1.PRM_ID
where 
  ENT_PARAM_NAMES.NODE_TYPE=@type

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_entity_params] TO [ap_public]
    AS [dbo];

