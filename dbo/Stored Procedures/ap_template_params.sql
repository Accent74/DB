
----------------------------------------
create procedure ap_template_params
@id int,
@type smallint = 0
as
set nocount on

-- возвращает все ID, имена и типы параметров и только нужные значения
select TML_ID,PRM_ID, PRM_LONG,PRM_STRING,PRM_DOUBLE,PRM_DATE,PRM_CY
into #tmp1 from TML_PARAMS where TML_ID=@id
 
select 
#tmp1.TML_ID,
TML_PARAM_NAMES.PRM_ID, 
TML_PARAM_NAMES.PRM_NAME,
TML_PARAM_NAMES.PRM_TYPE,
TML_PARAM_NAMES.PRM_REF,
TML_PARAM_NAMES.PRM_REFID,

#tmp1.PRM_LONG, #tmp1.PRM_STRING,#tmp1.PRM_DOUBLE,#tmp1.PRM_DATE,#tmp1.PRM_CY,
TML_PARAM_NAMES.PRM_DESCR	


from TML_PARAM_NAMES left join #tmp1 on TML_PARAM_NAMES.PRM_ID=#tmp1.PRM_ID
where TML_PARAM_NAMES.NODE_TYPE=@type

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_template_params] TO [ap_public]
    AS [dbo];

