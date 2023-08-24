----------------------------------------
create procedure ap_trash_info
@id int
as
set nocount on
declare @uname nvarchar(128)
declare @uid smallint
declare @dat datetime
select @uid = SYS_LOG.UID, @dat = max(SYS_LOG.LOG_DATE) from SYS_LOG 
  where SYS_LOG.ITEM_ID=@id and SYS_LOG.SYS_ACTION=N'D' 
  group by SYS_LOG.UID

select @uname = cast(sysusers.name as nvarchar(128)) from sysusers inner join SYS_LOG on sysusers.uid = SYS_LOG.UID
  where sysusers.uid=@uid

select @uname,@dat,DOC_DATE,DOC_NAME,DOC_TAG, DOCUMENTS.FLD_ID 
from DOCUMENTS where DOC_ID=@id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_trash_info] TO [ap_public]
    AS [dbo];

