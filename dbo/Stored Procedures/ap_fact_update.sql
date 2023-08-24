----------------------------------------
create procedure ap_fact_update
@et int,
@fid int,
@nid int,
@dt datetime,
@lng int,
@str nvarchar(256),
@dbl float,
@dat datetime,
@cy money

as
set nocount on
begin tran

declare @tnames nvarchar(32)
declare @tvals nvarchar(32)
declare @sql nvarchar(512)
declare @prm nvarchar(255)
declare @exists int

exec apx_et_facts @et, @tnames OUT, @tvals OUT
exec ap_fact_exists @et, @fid, @nid, @dt, @exists out

if @exists = 1 
  begin
   if @lng is null and @dbl is null and @dat is null and @cy is null and @str is null
       begin
        select @sql = N'delete from ' + @tvals + ' where FA_ID=@fid and EL_ID=@nid and FA_FDATE=@dt'
        select @prm = N'@fid int, @nid int, @dt datetime '
        execute sp_executesql @sql, @prm, @fid, @nid, @dt
       end
     else	
       select @sql = N'update ' + @tvals + 
	      N' set FA_LONG=@lng, FA_DOUBLE=@dbl, FA_DATE=@dat, FA_CY=@cy, FA_STRING=@str ' +
	      N' where FA_ID = @fid and EL_ID=@nid and FA_FDATE=@dt '

      select @prm = N'@fid int, @nid int, @dt datetime, @lng int, @dbl float, @dat datetime, @cy money, @str nvarchar(256)'
      execute sp_executesql @sql, @prm, @fid, @nid, @dt, @lng, @dbl, @dat, @cy, @str
  end
else
  begin
   if @lng is not null or @dbl is not null or @dat is not null or @cy is not null or @str is not null
     begin
       select @sql = N'insert into ' + @tvals +
	      N' (FA_LONG, FA_DOUBLE, FA_DATE, FA_CY, FA_STRING, FA_ID, EL_ID, FA_FDATE) ' +
              N' values (@lng,@dbl,@dat,@cy,@str,@fid,@nid,@dt) '

       select @prm = N'@fid int, @nid int, @dt datetime, @lng int, @dbl float, @dat datetime, @cy money, @str nvarchar(256)'
       execute sp_executesql @sql, @prm, @fid, @nid, @dt, @lng, @dbl, @dat, @cy, @str
     end
  end
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_fact_update] TO [ap_public]
    AS [dbo];

