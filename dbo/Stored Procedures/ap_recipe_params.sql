﻿----------------------------------------
create procedure ap_recipe_params
@id int,
@type smallint = 0
as

set nocount on
-- возвращает все ID, имена и типы параметров и только нужные значения
select 
  RP_ID,PRM_ID, PRM_LONG,PRM_STRING,PRM_DOUBLE,PRM_DATE,PRM_CY
into 
  #tmp1 
from 
  RCP_PARAMS where RP_ID=@id
 
select 
  #tmp1.RP_ID,
  RCP_PARAM_NAMES.PRM_ID, 
  RCP_PARAM_NAMES.PRM_NAME,
  RCP_PARAM_NAMES.PRM_TYPE,
  RCP_PARAM_NAMES.PRM_REF,
  RCP_PARAM_NAMES.PRM_REFID,
  #tmp1.PRM_LONG, #tmp1.PRM_STRING,#tmp1.PRM_DOUBLE,#tmp1.PRM_DATE,#tmp1.PRM_CY,
	RCP_PARAM_NAMES.PRM_DESCR	
from 
  RCP_PARAM_NAMES left join #tmp1 on RCP_PARAM_NAMES.PRM_ID=#tmp1.PRM_ID
where 
  RCP_PARAM_NAMES.NODE_TYPE=@type

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_recipe_params] TO [ap_public]
    AS [dbo];

