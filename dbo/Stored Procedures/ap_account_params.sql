----------------------------------------
create procedure ap_account_params
@id int,
@type smallint = 0
as

set nocount on
-- возвращает все ID, имена и типы параметров и только нужные значения
select 
  ACC_ID,PRM_ID, PRM_LONG,PRM_STRING,PRM_DOUBLE,PRM_DATE,PRM_CY
into 
  #tmp1 
from 
  ACC_PARAMS where ACC_ID=@id
 
select 
  #tmp1.ACC_ID,
  ACC_PARAM_NAMES.PRM_ID, 
  ACC_PARAM_NAMES.PRM_NAME,
  ACC_PARAM_NAMES.PRM_TYPE,
  ACC_PARAM_NAMES.PRM_REF,
  ACC_PARAM_NAMES.PRM_REFID,
  #tmp1.PRM_LONG, #tmp1.PRM_STRING,#tmp1.PRM_DOUBLE,#tmp1.PRM_DATE,#tmp1.PRM_CY,
	ACC_PARAM_NAMES.PRM_DESCR	
from 
  ACC_PARAM_NAMES left join #tmp1 on ACC_PARAM_NAMES.PRM_ID=#tmp1.PRM_ID
where 
  ACC_PARAM_NAMES.NODE_TYPE=@type

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_account_params] TO [ap_public]
    AS [dbo];

