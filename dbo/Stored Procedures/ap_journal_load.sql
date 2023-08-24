-----------------------------------------
create procedure ap_journal_load
@et int,
@id int,
@sd datetime,
@ed datetime,
@mcid int
with recompile
as
set nocount on
if @et = 0 and @id = 0 -- корень дерева документов
  begin
    select DOCUMENTS.DOC_ID,max(JOURNAL.J_TR_NO),DOCUMENTS.ST_ID, FLD_ID  
    from DOCUMENTS inner join JOURNAL on DOCUMENTS.DOC_ID = JOURNAL.DOC_ID
    where DOCUMENTS.MC_ID=@mcid and DOC_DONE<100 and ((DOC_DATE>=@sd and DOC_DATE<@ed) or (J_DATE>=@sd and J_DATE<@ed)) and
    (DOCUMENTS.FLD_ID=0 or DOCUMENTS.FLD_ID is null)
    group by DOCUMENTS.DOC_ID, DOCUMENTS.ST_ID, DOCUMENTS.DOC_DATE, FLD_ID
    order by DOCUMENTS.DOC_DATE, DOCUMENTS.DOC_ID
  end
else if @et = 0 -- папка
  begin
    select DOCUMENTS.DOC_ID, MAX(J_TR_NO), ST_ID, FLD_ID
    from DOCUMENTS inner join JOURNAL on DOCUMENTS.DOC_ID = JOURNAL.DOC_ID
    where  DOCUMENTS.MC_ID=@mcid and DOC_DONE<100 and ((DOC_DATE>=@sd And DOC_DATE<@ed ) or (J_DATE>=@sd and J_DATE<@ed)) and DOCUMENTS.FLD_ID=@id
    group by DOCUMENTS.DOC_ID, DOCUMENTS.ST_ID, DOCUMENTS.DOC_DATE, FLD_ID
    order by DOC_DATE, DOCUMENTS.DOC_ID
  end 
else if @et = 1 -- счет
  begin
    select DOCUMENTS.DOC_ID, (select max(J.J_TR_NO) from JOURNAL J where J.DOC_ID=DOCUMENTS.DOC_ID), ST_ID, FLD_ID
    from DOCUMENTS inner join JOURNAL on DOCUMENTS.DOC_ID = JOURNAL.DOC_ID 
    where  DOCUMENTS.MC_ID=@mcid and DOC_DONE<100 and ((DOC_DATE>=@sd And DOC_DATE <@ed) or (J_DATE>=@sd and J_DATE<@ed)) and (JOURNAL.ACC_DB=@id or JOURNAL.ACC_CR=@id) 
    group by DOCUMENTS.DOC_ID, DOCUMENTS.ST_ID, DOCUMENTS.DOC_DATE, FLD_ID
    order by DOC_DATE, DOCUMENTS.DOC_ID
  end
else if @et = 2 -- корреспондент
  begin
    select DOCUMENTS.DOC_ID, (select max(J.J_TR_NO) from JOURNAL J where J.DOC_ID=DOCUMENTS.DOC_ID), ST_ID, FLD_ID
    from DOCUMENTS inner join JOURNAL on DOCUMENTS.DOC_ID = JOURNAL.DOC_ID 
    where DOCUMENTS.MC_ID=@mcid and DOC_DONE<100 and ((DOC_DATE>=@sd And DOC_DATE <@ed) or (J_DATE>=@sd and J_DATE<@ed)) and 
          (JOURNAL.J_AG1=@id or JOURNAL.J_AG2=@id) 
    group by DOCUMENTS.DOC_ID, DOCUMENTS.ST_ID, DOCUMENTS.DOC_DATE, FLD_ID
    order by DOC_DATE, DOCUMENTS.DOC_ID
  end
else if @et = 3 -- объект учета
  begin
    select DOCUMENTS.DOC_ID, (select max(J.J_TR_NO) from JOURNAL J where J.DOC_ID=DOCUMENTS.DOC_ID), ST_ID, FLD_ID
    from DOCUMENTS inner join JOURNAL on DOCUMENTS.DOC_ID = JOURNAL.DOC_ID 
    where DOCUMENTS.MC_ID=@mcid and DOC_DONE<100 and ((DOC_DATE>=@sd And DOC_DATE <@ed) or (J_DATE>=@sd and J_DATE<@ed)) and JOURNAL.J_ENT=@id
    group by DOCUMENTS.DOC_ID, DOCUMENTS.ST_ID, DOCUMENTS.DOC_DATE, FLD_ID
    order by DOC_DATE, DOCUMENTS.DOC_ID
  end
else if @et = 4 -- разное
  begin
    select DOCUMENTS.DOC_ID, 
    (select max(J_TR_NO) from JOURNAL as JJ where JJ.DOC_ID=DOCUMENTS.DOC_ID), ST_ID, FLD_ID
    from (DOCUMENTS inner join JOURNAL on DOCUMENTS.DOC_ID = JOURNAL.DOC_ID)
    inner join JRN_MISC on JOURNAL.J_ID = JRN_MISC.J_ID 
    where DOCUMENTS.MC_ID=@mcid and DOC_DONE<100 and ((DOC_DATE>=@sd And DOC_DATE <@ed) or (J_DATE>=@sd and J_DATE<@ed)) and JRN_MISC.MSC_ID=@id
    group by DOCUMENTS.DOC_ID, DOCUMENTS.ST_ID, DOCUMENTS.DOC_DATE, FLD_ID
    order by DOC_DATE, DOCUMENTS.DOC_ID
  end
else if @et = 5 -- подшивка
  begin
    select DOCUMENTS.DOC_ID, max(J_TR_NO), ST_ID, FLD_ID
    from DOCUMENTS inner join JOURNAL on DOCUMENTS.DOC_ID = JOURNAL.DOC_ID 
    where DOCUMENTS.MC_ID=@mcid and DOC_DONE < 100 and ((DOC_DATE>=@sd And DOC_DATE <@ed) or (J_DATE>=@sd and J_DATE<@ed)) and DOCUMENTS.DOC_ID in (select DOC_ID from BIND_DOCS where BIND_ID=@id)
    group by DOCUMENTS.DOC_ID, DOC_DATE, ST_ID, FLD_ID 
    order by DOCUMENTS.DOC_DATE, DOCUMENTS.DOC_ID
  end
else if @et = 6 -- шаблон
  begin
    select DOCUMENTS.DOC_ID, max(JOURNAL.J_TR_NO), ST_ID, FLD_ID
    from DOCUMENTS inner join JOURNAL on DOCUMENTS.DOC_ID = JOURNAL.DOC_ID
    where DOCUMENTS.MC_ID=@mcid and DOC_DONE<100 and ((DOC_DATE>=@sd And DOC_DATE <@ed) or (J_DATE>=@sd and J_DATE<@ed)) and DOCUMENTS.TML_ID=@id
    group by DOCUMENTS.DOC_ID, DOCUMENTS.ST_ID, DOCUMENTS.DOC_DATE, FLD_ID
    order by DOC_DATE, DOCUMENTS.DOC_ID
  end
else if @et = 30 -- без шаблона
  begin
    select DOCUMENTS.DOC_ID, max(JOURNAL.J_TR_NO), ST_ID, FLD_ID
    from DOCUMENTS inner join JOURNAL on DOCUMENTS.DOC_ID = JOURNAL.DOC_ID
    where DOCUMENTS.MC_ID=@mcid and DOC_DONE<100 and ((DOC_DATE>=@sd And DOC_DATE <@ed) or (J_DATE>=@sd and J_DATE<@ed)) and 
          (DOCUMENTS.TML_ID is null or DOCUMENTS.TML_ID = 0)
    group by DOCUMENTS.DOC_ID, DOCUMENTS.ST_ID, DOCUMENTS.DOC_DATE, FLD_ID
    order by DOC_DATE, DOCUMENTS.DOC_ID
  end
else if @et = 31 -- незавершенные
  begin
    select DOCUMENTS.DOC_ID, max(JOURNAL.J_TR_NO), ST_ID, FLD_ID
    from DOCUMENTS inner join JOURNAL on DOCUMENTS.DOC_ID = JOURNAL.DOC_ID
    where DOCUMENTS.MC_ID=@mcid and ((DOC_DATE>=@sd And DOC_DATE <@ed) or (J_DATE>=@sd and J_DATE<@ed)) and (DOCUMENTS.DOC_DONE=0 or DOCUMENTS.DOC_DONE=1)
    group by DOCUMENTS.DOC_ID, DOCUMENTS.ST_ID, DOCUMENTS.DOC_DATE, FLD_ID
    order by DOC_DATE, DOCUMENTS.DOC_ID
  end
else if @et = 32 -- все
  begin
    select DOCUMENTS.DOC_ID, max(JOURNAL.J_TR_NO), ST_ID, FLD_ID
    from DOCUMENTS inner join JOURNAL on DOCUMENTS.DOC_ID = JOURNAL.DOC_ID
    where DOCUMENTS.MC_ID=@mcid and ((DOC_DATE>=@sd And DOC_DATE <@ed) or (J_DATE>=@sd and J_DATE<@ed)) and DOCUMENTS.DOC_DONE<100
    group by DOCUMENTS.DOC_ID, DOCUMENTS.ST_ID, DOCUMENTS.DOC_DATE, FLD_ID
    order by DOC_DATE, DOCUMENTS.DOC_ID
  end
else if @et = 34 -- удаленные
  begin
    select DOCUMENTS.DOC_ID, max(JOURNAL.J_TR_NO), ST_ID, FLD_ID
    from DOCUMENTS inner join JOURNAL on DOCUMENTS.DOC_ID = JOURNAL.DOC_ID
    where DOCUMENTS.MC_ID=@mcid and ((DOC_DATE>=@sd And DOC_DATE <@ed) or (J_DATE>=@sd and J_DATE<@ed)) and DOCUMENTS.DOC_DONE>=100
    group by DOCUMENTS.DOC_ID, DOCUMENTS.ST_ID, DOCUMENTS.DOC_DATE, FLD_ID
    order by DOC_DATE, DOCUMENTS.DOC_ID
  end
else if @et = 39 -- favorites
	begin
    select DOCUMENTS.DOC_ID, max(JOURNAL.J_TR_NO), ST_ID, FLD_ID
    from DOCUMENTS inner join JOURNAL on DOCUMENTS.DOC_ID = JOURNAL.DOC_ID
    where DOCUMENTS.MC_ID=@mcid and
			DOCUMENTS.DOC_ID in (select F_REF from FAVORITES where F_KIND=0 AND F_PARENT=@id)    
    group by DOCUMENTS.DOC_ID, DOCUMENTS.ST_ID, DOCUMENTS.DOC_DATE, FLD_ID
    order by DOC_DATE, DOCUMENTS.DOC_ID
	end

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_journal_load] TO [ap_public]
    AS [dbo];

