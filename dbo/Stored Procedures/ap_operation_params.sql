----------------------------------------
create procedure ap_operation_params
@id int,
@type smallint = 0
as

set nocount on
-- возвращает все ID, имена и типы параметров и только нужные значения
select 
  DOC_ID,PRM_ID, PRM_LONG,PRM_STRING,PRM_DOUBLE,PRM_DATE,PRM_CY
into 
  #tmp1 
from 
  DOC_PARAMS where DOC_ID=@id
 
select 
  #tmp1.DOC_ID,
  DOC_PARAM_NAMES.PRM_ID, 
  DOC_PARAM_NAMES.PRM_NAME,
  DOC_PARAM_NAMES.PRM_TYPE,
  DOC_PARAM_NAMES.PRM_REF,
  DOC_PARAM_NAMES.PRM_REFID,
  #tmp1.PRM_LONG, #tmp1.PRM_STRING,#tmp1.PRM_DOUBLE,#tmp1.PRM_DATE,#tmp1.PRM_CY,
	DOC_PARAM_NAMES.PRM_DESCR	
from 
  DOC_PARAM_NAMES left join #tmp1 on DOC_PARAM_NAMES.PRM_ID=#tmp1.PRM_ID
where 
  DOC_PARAM_NAMES.NODE_TYPE=@type

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_operation_params] TO [ap_public]
    AS [dbo];

