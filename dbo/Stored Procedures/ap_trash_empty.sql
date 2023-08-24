--------------------------------------------
create procedure ap_trash_empty
@mc int
as
set nocount on
begin tran
-- запишем все в LOG
declare @on nchar(2)
select @on = PRM_STR from SYS_PARAMS where PRM_NAME=N'LOG'
if upper(@on) = N'ON' 
  insert into SYS_LOG (ITEM,SYS_ACTION,ITEM_ID,GUID,ITEM_STR1, ITEM_STR2)
     select N'D',N'M',DOC_ID,DOC_GUID,HOST_NAME(),SYSTEM_USER from DOCUMENTS where DOC_DONE>=100 and MC_ID=@mc
delete from DOCUMENTS where DOC_DONE>=100 and MC_ID=@mc
exec ap_log_add N'R',N'E'
commit tran

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_trash_empty] TO [ap_public]
    AS [dbo];

