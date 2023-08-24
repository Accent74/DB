----------------------------------------
create procedure ap_updates_prm
as
set nocount on
select PRM_NAME, PRM_STRING, PRM_LONG from USR_PARAMS
  where PRM_NAME like N'CONFIG_NAME[0-9]' or PRM_NAME like N'CONFIG_VERSION[0-9]' 
  order by PRM_NAME

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_updates_prm] TO [ap_public]
    AS [dbo];

