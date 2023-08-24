----------------------------------------
create procedure ap_form_params
@id int,
@type smallint = 0
as
set nocount on

-- возвращает все ID, имена и типы параметров и только нужные значения
select FRM_PARAMS.FRM_ID, PRM_ID, PRM_LONG,PRM_STRING,PRM_DOUBLE,PRM_DATE,PRM_CY
into #tmp1 from FRM_PARAMS where FRM_ID=@id
select 
#tmp1.FRM_ID,
FRM_PARAM_NAMES.PRM_ID, 
FRM_PARAM_NAMES.PRM_NAME,
FRM_PARAM_NAMES.PRM_TYPE,
FRM_PARAM_NAMES.PRM_REF,
FRM_PARAM_NAMES.PRM_REFID,

#tmp1.PRM_LONG, #tmp1.PRM_STRING,#tmp1.PRM_DOUBLE,#tmp1.PRM_DATE,#tmp1.PRM_CY,
FRM_PARAM_NAMES.PRM_DESCR	

from FRM_PARAM_NAMES left join #tmp1 on FRM_PARAM_NAMES.PRM_ID=#tmp1.PRM_ID
where FRM_PARAM_NAMES.NODE_TYPE=@type


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_form_params] TO [ap_public]
    AS [dbo];

