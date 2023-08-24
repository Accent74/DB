----------------------------------------
create procedure ap_fact_delete
@et int,
@fid int,
@nid int,
@dt datetime
as
set nocount on

declare @tnames nvarchar(32)
declare @tvals nvarchar(32)
declare @sql nvarchar(512)
declare @prm nvarchar(255)

exec apx_et_facts @et, @tnames OUT, @tvals OUT

select @sql = N'delete from ' + @tvals + ' where FA_ID=@fid and EL_ID=@nid and FA_FDATE=@dt'
select @prm = N'@fid int, @nid int, @dt datetime '
execute sp_executesql @sql, @prm, @fid, @nid, @dt


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_fact_delete] TO [ap_public]
    AS [dbo];

