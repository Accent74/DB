----------------------------------------
create procedure ap_rep_doclist
@kind smallint,
@kid int,
@sd datetime,
@ed datetime,
@mcid int,
@sub bit = 0
as
set nocount on
declare @sql nvarchar(4000)
select @sql = N'select DISTINCT DOCUMENTS.DOC_ID, DOCUMENTS.DOC_DATE, DOCUMENTS.FRM_ID, ' +
              N'DOCUMENTS.DOC_SUM, DOCUMENTS.DOC_NAME, DOCUMENTS.DOC_MEMO, ' +
              N'DOCUMENTS.DOC_TAG, DOCUMENTS.DOC_NO, DOCUMENTS.DOC_DONE '
if @kind = 0 -- folder
  select @sql = @sql + N'from DOCUMENTS '
else if @kind = 4 -- misc
  select @sql = @sql + N'from (DOCUMENTS inner join JOURNAL on DOCUMENTS.DOC_ID = JOURNAL.DOC_ID) ' +
		       N'inner join JRN_MISC on JOURNAL.J_ID = JRN_MISC.J_ID '
else if @kind = 6 -- template
  select @sql = @sql + N'from DOCUMENTS '
else if @kind = 5 -- binder
  select @sql = @sql + N'from DOCUMENTS '
else if @kind = 32 -- all docs
  select @sql = @sql + N'from DOCUMENTS '
else if @kind = 1 /* account */ and @sub = 1
  select @sql = @sql + N'from DOCUMENTS inner join JOURNAL on DOCUMENTS.DOC_ID=JOURNAL.DOC_ID ' +
                                     N' inner join ACC_TREE AD on JOURNAL.ACC_DB=AD.ID ' +
                                     N' inner join ACC_TREE AC on JOURNAL.ACC_CR=AC.ID '
else 
  select @sql = @sql + N'from DOCUMENTS inner join JOURNAL on DOCUMENTS.DOC_ID=JOURNAL.DOC_ID '

select @sql = @sql + N' where DOCUMENTS.DOC_DATE >= @sd and DOCUMENTS.DOC_DATE < @ed and DOCUMENTS.DOC_DONE < 100 '
select @sql = @sql + N' and DOCUMENTS.MC_ID = @mcid '
if @kind = 0
  if @kid = 0
    select @sql = @sql +  N'and (DOCUMENTS.FLD_ID is null or DOCUMENTS.FLD_ID=0)'
  else
    select @sql = @sql +  N'and DOCUMENTS.FLD_ID=@kid '
else
if @kind = 1 /* account */ and @sub = 1
  select @sql = @sql + 
    N'and (JOURNAL.ACC_DB=@kid or JOURNAL.ACC_CR=@kid or AD.P0=@kid or AD.P1=@kid or AD.P2=@kid or AD.P3=@kid ' + 
    N'or AD.P4=@kid or AD.P5=@kid or AD.P6=@kid or AD.P7=@kid or AC.P0=@kid or AC.P1=@kid or AC.P2=@kid ' +
    N'or AC.P3=@kid or AC.P4=@kid or AC.P5=@kid or AC.P6=@kid or AC.P7=@kid) ' 
else
begin
  select @sql = @sql + 
  case @kind
    when 1 then N'and (JOURNAL.ACC_DB=@kid or JOURNAL.ACC_CR=@kid) ' 
    when 2 then N'and (JOURNAL.J_AG1=@kid or JOURNAL.J_AG2=@kid) '
    when 3 then N'and JOURNAL.J_ENT=@kid '
    when 4 then N'and JRN_MISC.MSC_ID=@kid '
    when 5 then N'and DOCUMENTS.DOC_ID in (select BIND_DOCS.DOC_ID from BIND_DOCS where BIND_ID=@kid) '
    when 6 then N'and DOCUMENTS.TML_ID=@kid '
    else N''
  end
end

select @sql = @sql + N'order by DOCUMENTS.DOC_DATE '
execute sp_executesql @sql, N'@kid int, @sd datetime, @ed datetime, @mcid int', @kid, @sd, @ed, @mcid

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_rep_doclist] TO [ap_public]
    AS [dbo];

