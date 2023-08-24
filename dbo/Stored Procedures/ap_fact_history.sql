----------------------------------------
create procedure ap_fact_history
@et int,
@fa int,
@el int
as
declare @tnames nvarchar(32)
declare @tvals nvarchar (32)
declare @sql nvarchar(256)
exec apx_et_facts @et, @tnames out, @tvals out
select @sql = 
 N'select FA_FDATE, FA_LONG, FA_STRING, FA_DOUBLE, FA_DATE, FA_CY from ' + @tvals +
 ' where FA_ID=@fa AND EL_ID=@el order by FA_FDATE desc'
exec sp_executesql @sql, N'@fa int, @el int', @fa, @el


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_fact_history] TO [ap_public]
    AS [dbo];

