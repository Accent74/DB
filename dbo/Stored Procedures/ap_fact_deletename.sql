----------------------------------------
create procedure ap_fact_deletename
@et int,
@id int
as
set nocount on

declare @tnames nvarchar(32)
declare @tvals  nvarchar(32)
declare @sql nvarchar(255)
 
exec apx_et_facts @et, @tnames OUT, @tvals OUT
select @sql = N'delete from ' + @tnames + ' where FA_ID = @id'
execute sp_executesql @sql, N'@id int', @id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_fact_deletename] TO [ap_public]
    AS [dbo];

