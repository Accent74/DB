-----------------------------------------
create procedure ap_menuaction_update
@pk int,
@name nvarchar(256),
@file nvarchar(256)
as
set nocount on
begin tran
declare @rv int
declare @no int
select @rv = 0
if @pk = 0 
begin
  -- insert
  select @no = 1 + max(MA_NO) from MENU_ACTIONS
  if @no is null 
    select @no = 1
  insert into MENU_ACTIONS (MA_NO,MA_NAME,MA_FILE) values (@no,@name,@file)
  select @rv = ident_current('MENU_ACTIONS')
end
else
begin
  -- update
  update MENU_ACTIONS set MA_NAME=@name, MA_FILE=@file where PK=@pk
  select @rv = @pk
end
commit tran
return @rv

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_menuaction_update] TO [ap_public]
    AS [dbo];

