----------------------------------------
create procedure ap_rep_journal
@ana smallint,
@plan int,
@crc int,
@sd datetime,
@ed datetime,
@mcid int
as
set nocount on
declare @sql nvarchar(4000)
select @sql = case @ana
when 0 then N'select DOCUMENTS.DOC_NAME, cast(0 as int), '
when 1 then N'select DOCUMENTS.DOC_NO, DOCUMENTS.FRM_ID, '
when 2 then N'select NULL,JOURNAL.J_AG1, '
when 3 then N'select NULL,JOURNAL.J_AG2, '
when 4 then N'select NULL,JOURNAL.J_ENT, '
end
if @crc = 1
  select @sql = @sql + N'JOURNAL.ACC_DB, JOURNAL.ACC_CR, sum(JOURNAL.J_SUM) as SUM '
else
  select @sql = @sql + N'JOURNAL.ACC_DB, JOURNAL.ACC_CR, sum(JRN_CRC.JC_SUM) as SUM '
if @ana <= 1 -- document
begin
  if @crc = 1
    select @sql = @sql +  N'from ((JOURNAL inner join DOCUMENTS on JOURNAL.DOC_ID=DOCUMENTS.DOC_ID)  inner join ACCOUNTS as AD on JOURNAL.ACC_DB=AD.ACC_ID) inner join ACCOUNTS as AC on JOURNAL.ACC_CR=AC.ACC_ID '
  else
    select @sql = @sql +  N'from (((JOURNAL inner join DOCUMENTS on JOURNAL.DOC_ID=DOCUMENTS.DOC_ID) inner join ACCOUNTS as AD on JOURNAL.ACC_DB=AD.ACC_ID) inner join ACCOUNTS as AC on JOURNAL.ACC_CR=AC.ACC_ID) inner join JRN_CRC on JOURNAL.J_ID=JRN_CRC.J_ID '
end
else -- journal
begin
  if @crc = 1
    select @sql = @sql + N'from (JOURNAL inner join ACCOUNTS as AD on JOURNAL.ACC_DB=AD.ACC_ID) inner join ACCOUNTS as AC on JOURNAL.ACC_CR=AC.ACC_ID '
  else
    select @sql = @sql + N'from ((JOURNAL inner join ACCOUNTS as AD on JOURNAL.ACC_DB=AD.ACC_ID) inner join ACCOUNTS as AC on JOURNAL.ACC_CR=AC.ACC_ID) inner join JRN_CRC on JOURNAL.J_ID=JRN_CRC.J_ID '
end

if @crc = 1
  select @sql = @sql + N'where JOURNAL.MC_ID=@mcid and J_DONE=2 and ACC_DB <> ACC_CR and J_DATE>=@sd and J_DATE<@ed and AC.ACC_PLAN=@plan and AD.ACC_PLAN=@plan '
else
  select @sql = @sql + N'where JOURNAL.MC_ID=@mcid and J_DONE=2 and ACC_DB <> ACC_CR and J_DATE >= @sd and J_DATE<@ed and AC.ACC_PLAN=@plan and AD.ACC_PLAN=@plan and JRN_CRC.CRC_ID=@crc '
select @sql = @sql + case @ana
 when 0 then N'group by DOCUMENTS.DOC_NAME, JOURNAL.ACC_DB, JOURNAL.ACC_CR '
 when 1 then N'group by DOCUMENTS.DOC_NO,DOCUMENTS.FRM_ID,JOURNAL.ACC_DB, JOURNAL.ACC_CR '
 when 2 then N'group by JOURNAL.ACC_DB, JOURNAL.ACC_CR, JOURNAL.J_AG1 '
 when 3 then N'group by JOURNAL.ACC_DB, JOURNAL.ACC_CR, JOURNAL.J_AG2 '
 when 4 then N'group by JOURNAL.ACC_DB, JOURNAL.ACC_CR, JOURNAL.J_ENT '
end
if @crc = 1
  select @sql = @sql + N'having sum(JOURNAL.J_SUM)<>0 '
else
  select @sql = @sql + N'having sum(JRN_CRC.JC_SUM)<>0 '
execute sp_executesql @sql, N'@plan int, @crc int, @sd datetime, @ed datetime, @mcid int', @plan, @crc, @sd, @ed, @mcid

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_rep_journal] TO [ap_public]
    AS [dbo];

