-----------------------------------------
create function [dbo].[afn_rw_from] 
(@mask int, @iscur smallint, @sub smallint, @et int, @rcs smallint)  
returns nvarchar(4000) 
as  
begin
 declare @sql nvarchar(4000)
 select @sql =  N' from JOURNAL '   
 if (@mask & (1024 + 2048 + 2)) <> 0
   select @sql = @sql + N'inner join DOCUMENTS with(nolck) on JOURNAL.DOC_ID=DOCUMENTS.DOC_ID '
 if @iscur = 1 
   select @sql = @sql + N'inner join JRN_CRC with(nolck) on JOURNAL.J_ID=JRN_CRC.J_ID '
 if @sub = 1 -- рекурсивно по счетам
   select @sql = @sql + N'inner join ACC_TREE as AD with(nolck) on JOURNAL.ACC_DB=AD.ID inner join ACC_TREE as AC on JOURNAL.ACC_CR=AC.ID '
 if @rcs = 1 -- recursive
   select @sql = @sql + 
     case @et
       when 2 /* agent */ then N'left join AG_TREE as A1 with(nolck) on JOURNAL.J_AG1=A1.ID left join AG_TREE as A2 on JOURNAL.J_AG2=A2.ID '
       when 3 /* entity*/ then N'inner join ENT_TREE as T with(nolck) on JOURNAL.J_ENT=T.ID '
       when 4 /* misc  */ then N'inner join JRN_MISC with(nolck) on JOURNAL.J_ID=JRN_MISC.J_ID inner join MISC_TREE as T on JRN_MISC.MSC_ID=T.ID '
       else N''
     end
 else   
   begin -- no recursive
     if @et = 4 -- misc
        select @sql = @sql + N'inner join JRN_MISC on JOURNAL.J_ID=JRN_MISC.J_ID '
   end
 return @sql
end
