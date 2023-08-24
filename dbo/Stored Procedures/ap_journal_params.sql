----------------------------------------
create procedure ap_journal_params
@id int,
@type smallint = 0
as
set nocount on

-- возвращает все ID, имена и типы параметров и только нужные значения
select J_ID,PRM_ID, PRM_LONG,PRM_STRING,PRM_DOUBLE,PRM_DATE,PRM_CY
into #tmp1 from JRN_PARAMS where J_ID=@id
 
select 
#tmp1.J_ID,
JRN_PARAM_NAMES.PRM_ID, 
JRN_PARAM_NAMES.PRM_NAME,
JRN_PARAM_NAMES.PRM_TYPE,
JRN_PARAM_NAMES.PRM_REF,
JRN_PARAM_NAMES.PRM_REFID,

#tmp1.PRM_LONG, #tmp1.PRM_STRING,#tmp1.PRM_DOUBLE,#tmp1.PRM_DATE,#tmp1.PRM_CY,
JRN_PARAM_NAMES.PRM_DESCR	

from JRN_PARAM_NAMES left join #tmp1 on JRN_PARAM_NAMES.PRM_ID=#tmp1.PRM_ID
where JRN_PARAM_NAMES.NODE_TYPE=@type

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_journal_params] TO [ap_public]
    AS [dbo];

