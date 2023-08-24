----------------------------------------
create procedure ap_srv_info
as
set nocount on
declare @size money
select @size = sum(size) * 8192 / (1024 * 1024) from sysfiles
select 
  cast(DB_NAME() as nvarchar(128)),
  cast(SYSTEM_USER as nvarchar(128)), 
  @@version, 
  crdate, 
  @size
from master.dbo.sysdatabases where dbid=DB_ID()


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_srv_info] TO [ap_public]
    AS [dbo];

