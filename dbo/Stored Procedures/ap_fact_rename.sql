---------------------------------------------------------------------
create procedure ap_fact_rename
@et int,
@id int,
@name nvarchar(256)
as
set nocount on
begin tran
declare @tnames nvarchar(64)
declare @tvals nvarchar(64)
declare @sql nvarchar(255)
declare @prm nvarchar(255)
 
exec apx_et_facts @et, @tnames OUT, @tvals OUT

if @tnames is null
  begin
    rollback tran
    raiserror (N'Недопустимый тип элемента',16,-1)
    return 0
  end
  
select @sql = N'UPDATE ' + 
	      @tnames + 
              N' SET FA_NAME = @name' +
	      N' WHERE FA_ID = @id'

select @prm = N'@id int, @name nvarchar(256)'

execute sp_executesql @sql, @prm, @id, @name

commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_fact_rename] TO [ap_public]
    AS [dbo];

