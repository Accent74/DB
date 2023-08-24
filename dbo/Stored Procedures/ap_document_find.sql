-----------------------------------------
create procedure ap_document_find
@w1 smallint,
@w2 smallint,
@w3 smallint,
@h1 smallint,
@h2 smallint,
@h3 smallint,
@v1 nvarchar(255),
@v2 nvarchar(255),
@v3 nvarchar(255),
@w4 smallint = null,
@h4 smallint = null,
@v4 nvarchar(255) = null,
@mc int = null
with recompile
as

set nocount on
set dateformat ymd

declare @sql nvarchar(4000)
declare @prm nvarchar(200)
declare @fn nvarchar(64)
declare @cr nvarchar(32)
declare @i int
declare @wx smallint
declare @hx smallint
declare @sx nvarchar(255)
declare @vx1 nvarchar(255)
declare @vx2 nvarchar(255)
declare @vx3 nvarchar(255)
declare @vx4 nvarchar(255)
declare @vx nvarchar(260)


select @sql = 
  N'select distinct top 101 DOCUMENTS.DOC_ID, DOCUMENTS.DOC_DATE, DOCUMENTS.DOC_NO, ' +
  N'isnull(DOCUMENTS.DOC_SUM,0), DOCUMENTS.DOC_NAME, DOCUMENTS.DOC_MEMO, DOCUMENTS.FRM_ID, ' +
  N'DOCUMENTS.DOC_DONE, DOCUMENTS.ST_ID ' + 
  N'from DOCUMENTS inner join JOURNAL on DOCUMENTS.DOC_ID=JOURNAL.DOC_ID where '

if @mc <> 0 and @mc is not null
  select @sql = @sql + N'JOURNAL.MC_ID=@mc and '
select @prm =
  N'@v1 nvarchar(255), @v2 nvarchar(255), @v3 nvarchar(255), @v4 nvarchar(255), @mc int '

select @i = 1

while @i <= 4
begin
  select @fn = null
  select @cr = null
  select @wx = case @i when 1 then @w1 when 2 then @w2 when 3 then @w3 when 4 then @w4 end
  select @hx = case @i when 1 then @h1 when 2 then @h2 when 3 then @h3 when 4 then @h4 end

  select @fn = 
  case @wx
    when 0  then N'DOC_DATE '
    when 1  then N'upper(DOC_NAME) '
    when 2  then N'upper(DOC_NO) ' 
    when 3  then N'upper(DOC_MEMO) ' 
    when 4  then N'DOC_SUM ' 
    when 5  then N'ACC_DB ' 
    when 6  then N'ACC_CR ' 
    when 7  then N'J_AG1 ' 
    when 8  then N'J_AG2 ' 
    when 9  then N'J_ENT ' 
    when 10 then N'J_SUM ' 
    when 11 then N'FRM_ID '
  end

  select @cr = 
  case @hx
    when 0 then N'Like ' -- including
    when 1 then N'= '    -- equal
    when 2 then N'Like ' -- beginning
    when 3 then N'> '    -- greater
    when 4 then N'< '    -- less then
  end

  select @vx = 
    case @i 
      when 1 then @v1 
      when 2 then @v2
      when 3 then @v3
      when 4 then @v4
    end
  if @hx = 0 or @hx = 2
  begin
    -- including, or starting -> add '%Like%' or 'Like%'
    select @vx = N''
    if @hx = 0 
      select @vx = @vx + N'%'
    select @vx = @vx + 
    case @i 
      when 1 then @v1 
      when 2 then @v2
      when 3 then @v3
      when 4 then @v4
    end   + N'%'
  end
  if @i = 1 
    select @vx1 = @vx
  else if @i = 2
    select @vx2 = @vx
  else if @i = 3
    select @vx3 = @vx
  else if @i = 4
    select @vx4 = @vx
  select @sx = N''
  if @i <> 1 and @fn is not null
    select @sx = @sx + ' and '
  if @wx = 4 or @wx = 10 
  begin
   -- сумма
    select @sx = @sx + @fn + @cr + N'cast(' +
    case @i 
      when 1 then N'@v1' 
      when 2 then N'@v2' 
      when 3 then N'@v3' 
      when 4 then N'@v4'
    end +
    N' as money)'
  end
  else 
  -- long
  begin
    select @sx = @sx + @fn + @cr + 
    case @i 
      when 1 then N'@v1' 
      when 2 then N'@v2' 
      when 3 then N'@v3' 
      when 4 then N'@v4'
    end
  end
  select @i = @i + 1
  if @sx is not null
    select @sql = @sql + @sx
end -- while

execute sp_executesql @sql, @prm, @vx1, @vx2, @vx3, @vx4, @mc


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_document_find] TO [ap_public]
    AS [dbo];

