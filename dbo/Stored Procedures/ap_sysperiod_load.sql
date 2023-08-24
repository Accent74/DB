----------------------------------------
create procedure ap_sysperiod_load
as
set nocount on
select PRM_NAME,PRM_STR,PRM_LONG,PRM_DATE 
  from SYS_PARAMS where PRM_NAME=N'START_DATE' or PRM_NAME=N'END_DATE'

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_sysperiod_load] TO [ap_public]
    AS [dbo];

