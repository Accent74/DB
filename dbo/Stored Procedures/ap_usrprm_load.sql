-------------------------------------------
create procedure ap_usrprm_load
@name nvarchar(256)
as
set nocount on
select PRM_TYPE, PRM_STRING, PRM_CY, PRM_LONG, PRM_DATE
from USR_PARAMS WHERE PRM_NAME=@name


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_usrprm_load] TO [ap_public]
    AS [dbo];

