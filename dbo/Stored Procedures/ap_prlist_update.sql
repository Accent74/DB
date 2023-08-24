-----------------------------------------
create procedure ap_prlist_update
@id int,
@name nvarchar(256),
@memo nvarchar(256) = null,
@flags int = null
as
set nocount on
declare @resid int
select @resid = @id

begin tran
if @flags is null
  select @flags = 0
if @flags <> 0
  update PRL_LISTS set PRL_FLAGS=null

if @id = 0
  begin 
    -- insert new and returns ID
    insert into PRL_LISTS (PRL_NAME,PRL_MEMO,PRL_FLAGS) values (@name,@memo,@flags)
    select @resid = ident_current('PRL_LISTS')
  end
else
  begin
    -- update only
    update PRL_LISTS set PRL_NAME=@name, PRL_MEMO=@memo, PRL_FLAGS=@flags where PRL_ID=@id
  end
commit tran
return @resid

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_prlist_update] TO [ap_public]
    AS [dbo];

