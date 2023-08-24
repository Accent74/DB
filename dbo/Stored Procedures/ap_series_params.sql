----------------------------------------
create procedure ap_series_params
@id int,
@type smallint = 0
as
set nocount on

select @type = 0
-- возвращает все ID, имена и типы параметров и только нужные значения
select SER_PARAMS.SER_ID, PRM_ID, PRM_LONG,PRM_STRING,PRM_DOUBLE,PRM_DATE,PRM_CY
into #tmp1 from SER_PARAMS where SER_ID=@id 
select 
#tmp1.SER_ID,
SER_PARAM_NAMES.PRM_ID, 
SER_PARAM_NAMES.PRM_NAME,
SER_PARAM_NAMES.PRM_TYPE,
SER_PARAM_NAMES.PRM_REF,
SER_PARAM_NAMES.PRM_REFID,

#tmp1.PRM_LONG, #tmp1.PRM_STRING,#tmp1.PRM_DOUBLE,#tmp1.PRM_DATE,#tmp1.PRM_CY,
SER_PARAM_NAMES.PRM_DESCR	

from SER_PARAM_NAMES left join #tmp1 on SER_PARAM_NAMES.PRM_ID=#tmp1.PRM_ID
where SER_PARAM_NAMES.NODE_TYPE=@type


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_series_params] TO [ap_public]
    AS [dbo];

