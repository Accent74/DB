----------------------------------------
create procedure ap_folder_params
@id int,
@type smallint = 0
as
set nocount on

-- возвращает все ID, имена и типы параметров и только нужные значения
select FLD_ID,PRM_ID, PRM_LONG,PRM_STRING,PRM_DOUBLE,PRM_DATE,PRM_CY
into #tmp1 from FLD_PARAMS where FLD_ID=@id
 
select 
#tmp1.FLD_ID,
FLD_PARAM_NAMES.PRM_ID, 
FLD_PARAM_NAMES.PRM_NAME,
FLD_PARAM_NAMES.PRM_TYPE,
FLD_PARAM_NAMES.PRM_REF,
FLD_PARAM_NAMES.PRM_REFID,
#tmp1.PRM_LONG, #tmp1.PRM_STRING,#tmp1.PRM_DOUBLE,#tmp1.PRM_DATE,#tmp1.PRM_CY,
FLD_PARAM_NAMES.PRM_DESCR

from FLD_PARAM_NAMES left join #tmp1 on FLD_PARAM_NAMES.PRM_ID=#tmp1.PRM_ID
where FLD_PARAM_NAMES.NODE_TYPE=@type

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_folder_params] TO [ap_public]
    AS [dbo];

