----------------------------------------
create procedure ap_fact_exists
@et int,
@pid int,
@nid int,
@dt datetime,
@exists int output
as
set nocount on

declare @tnames nvarchar(32)
declare @tvals nvarchar(32)
declare @sql nvarchar(1024)
declare @prm nvarchar(256)
declare @val int

exec apx_et_facts @et, @tnames OUT, @tvals OUT

select @sql = N' select @val = case when exists(select * from ' + @tvals + 
              N' where FA_ID=@pid and EL_ID = @nid and FA_FDATE=@dt) then 1 else 0 end'

select @prm = N'@pid int, @nid int, @dt datetime, @val int OUT'

exec sp_executesql @sql, @prm, @pid, @nid, @dt, @val out
select @exists = @val


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_fact_exists] TO [ap_public]
    AS [dbo];

