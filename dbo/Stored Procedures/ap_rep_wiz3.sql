----------------------------------------
create procedure ap_rep_wiz3
@mask  int      = 1, -- маска
@et    int      = 1, -- тип объекта
@eid   int      = 0, -- ID объекта
@acc   int      = 0, -- ID счета
@crc   int      = 1, -- валюта
@sd    datetime = null,
@ed    datetime = null,
@trn   smallint = 0, -- обороты
@sub   smallint = 0, -- субсчета
@recur smallint = 0, -- рекурсия
@msc1  int      = 0, -- misc number (FIELD)
@msc2  int      = 0, -- misc number (TREE)
@mc    int      = 0, -- my compay
@excl  int      = 0  -- exclude doc
with recompile
as

set nocount on

declare @iscur smallint
declare @sql nvarchar(4000)
declare @prm nvarchar(256)
declare @dst smallint
select @dst = 0
if (@crc = 1) or (@crc = 0)
  select @iscur = 0
else
  select @iscur = 1
if (@sub = 1) or (@recur = 1)
  select @dst = 1
select @prm = N'@sd datetime, @ed datetime, @acc int, @eid int, @crc int, @msc1 int, @msc2 int, @mc int, @excl int'
select @sql = dbo.afn_rw_fields(@mask, @iscur, @dst)
select @sql = @sql + dbo.afn_rw_from(@mask, @iscur, @sub, @et, @recur)
select @sql = @sql + dbo.afn_rw_where(@mask, @iscur, @trn, @sub, @mc, @et, @recur, @excl)
select @sql = @sql + dbo.afn_rw_groupby(@mask, @iscur, @trn, @sub, @dst)
execute sp_executesql @sql, @prm, @sd, @ed, @acc, @eid, @crc, @msc1, @msc2,  @mc, @excl

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_rep_wiz3] TO [ap_public]
    AS [dbo];

