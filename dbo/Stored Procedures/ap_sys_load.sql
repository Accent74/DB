----------------------------------------
create procedure ap_sys_load
as
set nocount on
select PRM_NAME,PRM_STR,PRM_LONG,PRM_DATE from SYS_PARAMS

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_sys_load] TO [ap_public]
    AS [dbo];

