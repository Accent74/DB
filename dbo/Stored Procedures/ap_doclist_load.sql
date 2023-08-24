-----------------------------------------
create procedure ap_doclist_load
@et smallint,
@id int,
@sd datetime,
@ed datetime,
@showtrans bit = 0,
@unlink bit = 0,
@frm int = null,
@mcid int = null
with recompile
as

set nocount on

declare @sql nvarchar(4000)
declare @prm nvarchar(200)

select @prm =
  N'@sd datetime, @ed datetime, @id int, @frm int, @mcid int'

select @sql = 
  N'SELECT DISTINCT DOCUMENTS.DOC_ID, DOCUMENTS.DOC_DONE,DOCUMENTS.DOC_DATE, ' +
  N'DOCUMENTS.DOC_NAME, DOCUMENTS.DOC_MEMO, DOCUMENTS.DOC_NO,' +
  N'DOCUMENTS.FRM_ID, DOCUMENTS.DOC_SUM,DOCUMENTS.ST_ID,' +
  N'DOCUMENTS.DOC_TAG, DOCUMENTS.DOC_LINK, DOCUMENTS.TML_ID, ' +
  N'DOCUMENTS.DOC_PS1, DOCUMENTS.DOC_PS2, DOCUMENTS.DOC_PS3, ' + 
  N'DOCUMENTS.DOC_PL1, DOCUMENTS.DOC_PL2, DOCUMENTS.DOC_PL3, ' +
  N'DOCUMENTS.DOC_PD1, DOCUMENTS.DOC_PD2, DOCUMENTS.DOC_PD3, ' +
  N'DOCUMENTS.DOC_PC1, DOCUMENTS.DOC_PC2, DOCUMENTS.DOC_PC3, ' +
  N'case when exists(SELECT * FROM BIND_DOCS AS T WHERE DOCUMENTS.DOC_ID=T.DOC_ID) then 1 else 0 end, ' +
  N'DOCUMENTS.FLD_ID, DOCUMENTS.DOC_XSTATUS ' 

if @et = 0 -- folder
begin
  select @sql = @sql + N' from DOCUMENTS left join JOURNAL on DOCUMENTS.DOC_ID=JOURNAL.DOC_ID '
  if @id = 0 -- root
    select @sql = @sql +   N'where (DOCUMENTS.FLD_ID is null or DOCUMENTS.FLD_ID=0) '
  else -- normal folder
    select @sql = @sql + N'where DOCUMENTS.FLD_ID=@id '
end
else if @et = 1  -- account
  select @sql = @sql + N'from DOCUMENTS left join JOURNAL on DOCUMENTS.DOC_ID=JOURNAL.DOC_ID ' +
      N'where (JOURNAL.ACC_DB=@id or JOURNAL.ACC_CR=@id) '
else if @et = 2  -- agent
  select @sql = @sql + N'from DOCUMENTS left join JOURNAL on DOCUMENTS.DOC_ID=JOURNAL.DOC_ID ' +
      N'where (JOURNAL.J_AG1=@id or JOURNAL.J_AG2=@id) '
else if @et = 3  -- entity
  select @sql = @sql + N'from DOCUMENTS left join JOURNAL on DOCUMENTS.DOC_ID=JOURNAL.DOC_ID ' +
      N'where JOURNAL.J_ENT=@id  '
else if @et = 4 --misc
  select @sql = @sql + N'from (DOCUMENTS left join JOURNAL on DOCUMENTS.DOC_ID = JOURNAL.DOC_ID)  left join JRN_MISC on JOURNAL.J_ID = JRN_MISC.J_ID ' +
      N'where JRN_MISC.MSC_ID=@id '
else if @et = 5 -- binder
  select @sql = @sql + N'from (DOCUMENTS left join JOURNAL on DOCUMENTS.DOC_ID = JOURNAL.DOC_ID) left join BIND_DOCS on DOCUMENTS.DOC_ID = BIND_DOCS.DOC_ID ' +
      N'where BIND_DOCS.BIND_ID=@id  '
else if @et = 6 -- template
  select @sql = @sql + N'from DOCUMENTS left JOIN JOURNAL on DOCUMENTS.DOC_ID=JOURNAL.DOC_ID where DOCUMENTS.TML_ID=@id  '
else if @et = 14 -- form
  select @sql = @sql + N'from DOCUMENTS left JOIN JOURNAL on DOCUMENTS.DOC_ID=JOURNAL.DOC_ID where DOCUMENTS.FRM_ID=@id  '
else if @et = 15 -- links
  select @sql = @sql + N'from DOCUMENTS where DOCUMENTS.DOC_LINK=@id '
else if @et = 30 -- untemplate
  select @sql = @sql + N'from DOCUMENTS left join JOURNAL on DOCUMENTS.DOC_ID=JOURNAL.DOC_ID where ' +
                       N'(DOCUMENTS.TML_ID is null or DOCUMENTS.TML_ID=0) '
else if @et = 31 -- uncomplete_docs
  select @sql = @sql + N'from DOCUMENTS left join JOURNAL on DOCUMENTS.DOC_ID=JOURNAL.DOC_ID where (DOCUMENTS.DOC_DONE=0 or DOCUMENTS.DOC_DONE=1) '
else if @et = 32 -- all docs
  select @sql = @sql + N'from DOCUMENTS left join JOURNAL on DOCUMENTS.DOC_ID=JOURNAL.DOC_ID where DOCUMENTS.DOC_DONE < 100 '
else if @et = 34 -- trash
  select @sql = @sql + N'from DOCUMENTS left join JOURNAL on DOCUMENTS.DOC_ID=JOURNAL.DOC_ID where DOCUMENTS.DOC_DONE >= 100 '
else if @et = 39 -- favorites
  select @sql = @sql + N'from DOCUMENTS left JOIN JOURNAL on DOCUMENTS.DOC_ID=JOURNAL.DOC_ID where DOCUMENTS.DOC_ID in (select F_REF from FAVORITES where F_KIND=0 AND F_PARENT=@id) '

select @sql = @sql + N' and DOCUMENTS.MC_ID=@mcid '
/* for links and favorites date not needed */
if @et <> 15 and @et <> 39
   select @sql = @sql + N' and ((DOCUMENTS.DOC_DATE>=@sd and DOCUMENTS.DOC_DATE<@ed) or (JOURNAL.J_DATE>=@sd and JOURNAL.J_DATE<@ed)) '
if @et <> 31 and @et <> 34 
  select @sql = @sql + N' and DOCUMENTS.DOC_DONE < 100 '
/* for links showtrans not used */
if @showtrans = 0 and @et <> 15
  select @sql = @sql +  N' and DOCUMENTS.FRM_ID IS NOT NULL'
if @unlink = 1 and @et <> 15
  begin
  select @sql = @sql + N' and (DOCUMENTS.DOC_LINK is null or DOCUMENTS.DOC_LINK=0) '
  if @frm is not null and @frm <> 0
    select @sql = @sql + N' and DOCUMENTS.FRM_ID = @frm '
  end

execute sp_executesql @sql, @prm, @sd, @ed, @id, @frm, @mcid

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_doclist_load] TO [ap_public]
    AS [dbo];

