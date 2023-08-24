----------------------------------------
create procedure ap_binder_params
@id int,
@type smallint = 0
as

set nocount on
-- возвращает все ID, имена и типы параметров и только нужные значения
select 
  BIND_ID,PRM_ID, PRM_LONG,PRM_STRING,PRM_DOUBLE,PRM_DATE,PRM_CY
into 
  #tmp1 
from 
  BIND_PARAMS where BIND_ID=@id
 
select 
  #tmp1.BIND_ID,
  BIND_PARAM_NAMES.PRM_ID, 
  BIND_PARAM_NAMES.PRM_NAME,
  BIND_PARAM_NAMES.PRM_TYPE,
  BIND_PARAM_NAMES.PRM_REF,
  BIND_PARAM_NAMES.PRM_REFID,
  #tmp1.PRM_LONG, #tmp1.PRM_STRING,#tmp1.PRM_DOUBLE,#tmp1.PRM_DATE,#tmp1.PRM_CY,
	BIND_PARAM_NAMES.PRM_DESCR	
from 
  BIND_PARAM_NAMES left join #tmp1 on BIND_PARAM_NAMES.PRM_ID=#tmp1.PRM_ID
where 
  BIND_PARAM_NAMES.NODE_TYPE=@type

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_binder_params] TO [ap_public]
    AS [dbo];

