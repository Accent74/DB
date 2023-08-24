----------------------------------------
create procedure ap_misc_params
@id int,
@type smallint = 0
as

set nocount on
-- возвращает все ID, имена и типы параметров и только нужные значения
select 
  MSC_ID,PRM_ID, PRM_LONG,PRM_STRING,PRM_DOUBLE,PRM_DATE,PRM_CY
into 
  #tmp1 
from 
  MISC_PARAMS where MSC_ID=@id
 
select 
  #tmp1.MSC_ID,
  MISC_PARAM_NAMES.PRM_ID, 
  MISC_PARAM_NAMES.PRM_NAME,
  MISC_PARAM_NAMES.PRM_TYPE,
  MISC_PARAM_NAMES.PRM_REF,
  MISC_PARAM_NAMES.PRM_REFID,
  #tmp1.PRM_LONG, #tmp1.PRM_STRING,#tmp1.PRM_DOUBLE,#tmp1.PRM_DATE,#tmp1.PRM_CY,
	MISC_PARAM_NAMES.PRM_DESCR	
from 
  MISC_PARAM_NAMES left join #tmp1 on MISC_PARAM_NAMES.PRM_ID=#tmp1.PRM_ID
where 
  MISC_PARAM_NAMES.NODE_TYPE=@type

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_misc_params] TO [ap_public]
    AS [dbo];

