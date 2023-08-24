----------------------------------------
create procedure ap_recipentry_params
@id int,
@type smallint = 0
as

set nocount on
-- возвращает все ID, имена и типы параметров и только нужные значения
select 
  RC_ID,PRM_ID, PRM_LONG,PRM_STRING,PRM_DOUBLE,PRM_DATE,PRM_CY
into 
  #tmp1 
from 
  RPE_PARAMS where RC_ID=@id
 
select 
  #tmp1.RC_ID,
  RPE_PARAM_NAMES.PRM_ID, 
  RPE_PARAM_NAMES.PRM_NAME,
  RPE_PARAM_NAMES.PRM_TYPE,
  RPE_PARAM_NAMES.PRM_REF,
  RPE_PARAM_NAMES.PRM_REFID,
  #tmp1.PRM_LONG, #tmp1.PRM_STRING,#tmp1.PRM_DOUBLE,#tmp1.PRM_DATE,#tmp1.PRM_CY,
	RPE_PARAM_NAMES.PRM_DESCR	
from 
  RPE_PARAM_NAMES left join #tmp1 on RPE_PARAM_NAMES.PRM_ID=#tmp1.PRM_ID
where 
  RPE_PARAM_NAMES.NODE_TYPE=@type

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_recipentry_params] TO [ap_public]
    AS [dbo];

