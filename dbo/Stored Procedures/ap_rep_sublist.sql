----------------------------------------
create procedure ap_rep_sublist
@kind smallint,
@id int,
@id2 int,
@crc int,
@sd datetime,
@ed datetime,
@mcid int
as
set nocount on

declare @sql nvarchar(4000)

select @sql = 
  N'select DOCUMENTS.DOC_ID, sum(JOURNAL.J_SUM) AS S, JOURNAL.J_DATE,
    JOURNAL.ACC_DB,JOURNAL.ACC_CR, JOURNAL.J_AG1, JOURNAL.J_AG2, JOURNAL.J_ENT,
    DOCUMENTS.FRM_ID, DOCUMENTS.DOC_NAME, DOCUMENTS.DOC_TAG,
    DOCUMENTS.DOC_NO, JOURNAL.J_DONE, JOURNAL.J_UN, sum(JOURNAL.J_QTY)'
if @kind = 4 -- misc
  select @sql = @sql +
  N'from (DOCUMENTS INNER JOIN JOURNAL ON DOCUMENTS.DOC_ID = JOURNAL.DOC_ID)
   inner join JRN_MISC ON JOURNAL.J_ID = JRN_MISC.J_ID '
else -- all other
  select @sql = @sql + 
  N'from DOCUMENTS inner join JOURNAL on DOCUMENTS.DOC_ID=JOURNAL.DOC_ID '

select @sql = @sql + N'where JOURNAL.J_DATE >= @sd and JOURNAL.J_DATE < @ed and DOCUMENTS.DOC_DONE<100 '
select @sql = @sql + N'and DOCUMENTS.MC_ID = @mcid '
if @kind = 0
  if @id = 0
    select @sql = @sql +  N'and (DOCUMENTS.FLD_ID is null or DOCUMENTS.FLD_ID=0)'
  else
    select @sql = @sql +  N'and DOCUMENTS.FLD_ID=@id '
else
select @sql = @sql +
case @kind
  when 1 -- account
    then N'and (JOURNAL.ACC_DB=@id OR JOURNAL.ACC_CR=@id) '
  when 2 -- agent
    then N'and (JOURNAL.J_AG1=@id or JOURNAL.J_AG2=@id) '
  when 3 -- entity
    then N'and JOURNAL.J_ENT=@id '
  when 4 -- misc
    then N'and JRN_MISC.MSC_ID=@id '
  when 35 -- pair
    then N'and JOURNAL.ACC_DB=@id and JOURNAL.ACC_CR=@id2 '
  when 36 -- db only
    then N'and JOURNAL.ACC_DB=@id '
  when 37 -- cr only
    then N'and JOURNAL.ACC_CR=@id '
  when 32 -- all docs
    then N''
end  

select @sql = @sql + 
  N'group by DOCUMENTS.DOC_ID, JOURNAL.J_DATE,JOURNAL.ACC_DB,JOURNAL.ACC_CR, JOURNAL.J_AG1, JOURNAL.J_AG2, JOURNAL.J_ENT, 
    DOCUMENTS.FRM_ID, DOCUMENTS.DOC_NAME, DOCUMENTS.DOC_TAG,DOCUMENTS.DOC_NO, JOURNAL.J_DONE, JOURNAL.J_UN 
    order by JOURNAL.J_DATE'

exec sp_executesql @sql, N'@id int,@id2 int, @sd datetime,@ed datetime, @mcid int', @id, @id2, @sd, @ed, @mcid

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_rep_sublist] TO [ap_public]
    AS [dbo];

