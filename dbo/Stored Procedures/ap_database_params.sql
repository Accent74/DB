----------------------------------------
create procedure ap_database_params
@id int,
@type smallint = 0
as
set nocount on

-- возвращает все ID, имена и типы параметров и только нужные значения
select DB_PARAMS.DB_ID, PRM_ID, PRM_LONG,PRM_STRING,PRM_DOUBLE,PRM_DATE,PRM_CY
into #tmp1 from DB_PARAMS
 
select 
#tmp1.DB_ID,
DB_PARAM_NAMES.PRM_ID, 
DB_PARAM_NAMES.PRM_NAME,
DB_PARAM_NAMES.PRM_TYPE,
DB_PARAM_NAMES.PRM_REF,
DB_PARAM_NAMES.PRM_REFID,

#tmp1.PRM_LONG, #tmp1.PRM_STRING,#tmp1.PRM_DOUBLE,#tmp1.PRM_DATE,#tmp1.PRM_CY,
DB_PARAM_NAMES.PRM_DESCR	

from DB_PARAM_NAMES left join #tmp1 on DB_PARAM_NAMES.PRM_ID=#tmp1.PRM_ID
where DB_PARAM_NAMES.NODE_TYPE=@type

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_database_params] TO [ap_public]
    AS [dbo];

