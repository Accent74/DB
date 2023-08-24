-----------------------------------------
-- stored procedures
-----------------------------------------
create procedure ap_log_add
@itm nchar(1),
@act nchar(1),
@itmid int = null,
@itmdate datetime = null,
@itmcy money = null,
@itms1 nvarchar(50) = null,
@itms2 nvarchar(50) = null,
@guid uniqueidentifier = null
as
set nocount on
if @itms1 is null
  select @itms1 = HOST_NAME()
if @itms2 is null
  select @itms2 = SYSTEM_USER
-- всегда внутри транзакции!
declare @on nchar(2)
select @on = PRM_STR from SYS_PARAMS where PRM_NAME=N'LOG'
if upper(@on) = N'ON' 
  insert into SYS_LOG (ITEM,SYS_ACTION,ITEM_ID,ITEM_DATE,ITEM_CY,ITEM_STR1,ITEM_STR2,GUID)
  values (@itm,@act,@itmid,@itmdate,@itmcy,@itms1,@itms2,@guid)


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_log_add] TO [ap_public]
    AS [dbo];

