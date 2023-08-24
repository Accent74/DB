-----------------------------------------
create procedure ap_accplan_createnew
@code nvarchar(51),
@name nvarchar(256),
@guid uniqueidentifier = null
as
set nocount on

declare @id int

begin tran
if @guid is null
begin
  insert into ACCOUNTS (ACC_PLAN,ACC_PL_CODE,ACC_TYPE,ACC_NAME,ACC_CODE) values
     (0,@code,-1,@name,@code)
  select @id = ident_current('ACCOUNTS')
end
else
begin
  insert into ACCOUNTS (ACC_PLAN,ACC_PL_CODE,ACC_TYPE,ACC_NAME,ACC_CODE,ACC_GUID) values
    (0,@code,-1,@name,@code,@guid)
  select @id = ident_current('ACCOUNTS')
end
update ACCOUNTS set ACC_PLAN=@id where ACC_ID=@id
-- в дереве всегда в корне
insert into ACC_TREE (ID)values (@id)
-- остальные значения по умолчанию
commit tran
return @id

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_accplan_createnew] TO [ap_public]
    AS [dbo];

