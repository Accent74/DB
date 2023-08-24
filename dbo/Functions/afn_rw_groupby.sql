-----------------------------------------
create function [dbo].[afn_rw_groupby] 
(@mask int, @iscur smallint, @trn smallint, @sub smallint, @dst smallint)  
returns nvarchar(4000) 
as  
begin
 declare @sql nvarchar(4000)
 select @sql = N'group by '
 -- date
 if (@mask & 1) <> 0 
   select @sql = @sql + N'JOURNAL.J_DATE, '
 -- ent
 if (@mask & 8) <> 0 
   select @sql = @sql + N'JOURNAL.J_ENT, '
 -- agent
 if (@mask & 4) <> 0 
   select @sql = @sql + N'JOURNAL.J_AG1, JOURNAL.J_AG2, '
 -- series
 if (@mask & 32) <> 0 
   select @sql = @sql + N'JOURNAL.SER_ID, '
 -- docid
 if (@mask & 128) <> 0 
   select @sql = @sql + N'JOURNAL.DOC_ID, '
 -- misc
 if ((@mask & 16) <> 0) or (@dst = 1)
   select @sql = @sql + N'JOURNAL.J_ID, '
 -- frm
 if (@mask & (2 + 1024 + 2048)) <> 0 
   select @sql = @sql + N'DOCUMENTS.FRM_ID, '
 -- pdoc
 if (@mask & 64) <> 0 
   select @sql = @sql + N'JOURNAL.PDOC_ID, '
 -- docno
 if (@mask & 2) <> 0 
   select @sql = @sql + N'DOCUMENTS.DOC_NO, '
 -- name
 if (@mask & 1024) <> 0 
   select @sql = @sql + N'DOCUMENTS.DOC_NAME, '
 -- memo
 if (@mask & 2048) <> 0 
   select @sql = @sql + N'DOCUMENTS.DOC_MEMO, '
-- reptax
 if ((@mask & 512) <> 0) or (@dst = 1)
   select @sql = @sql + N'JOURNAL.J_ID, '
 select @sql =  @sql + N'JOURNAL.ACC_DB, JOURNAL.ACC_CR '   
 return @sql
end
