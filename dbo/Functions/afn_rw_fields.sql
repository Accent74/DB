----------------------------------------
-- user defined functions
-----------------------------------------
create function [dbo].[afn_rw_fields] 
(@mask int, @iscur smallint, @dst smallint)  
returns nvarchar(4000) 
as  
begin		
 declare @sql nvarchar(4000)
 select @sql =  N'select '   
 -- date
 if (@mask & 1) <> 0
   select @sql = @sql + N'JOURNAL.J_DATE, '
 else
   select @sql = @sql + N'NULL, '
 -- entity
 if (@mask & 8) <> 0
   select @sql = @sql + N'JOURNAL.J_ENT, '
 else
   select @sql = @sql + N'0, '
 -- agent
 if (@mask & 4) <> 0
   select @sql = @sql + N'JOURNAL.J_AG1, JOURNAL.J_AG2, '
 else
   select @sql = @sql + N'0, 0, '
 -- series
 if (@mask & 32) <> 0
   select @sql = @sql + N'JOURNAL.SER_ID, '
 else
   select @sql = @sql + N'0, '
 -- docid
 if (@mask & 128) <> 0
   select @sql = @sql + N'JOURNAL.DOC_ID, '
 else
   select @sql = @sql + N'0, '
 -- misc
 if (@mask & 16) <> 0
   select @sql = @sql + N'(select MSC_ID from JRN_MISC where JRN_MISC.J_ID=JOURNAL.J_ID and JRN_MISC.MSC_NO=@msc1),'
 else
   select @sql = @sql + N'0, '
 -- frm
 if (@mask & (1024 + 2048 + 2)) <> 0
   select @sql = @sql + N'DOCUMENTS.FRM_ID, '
 else
   select @sql = @sql + N'0, '
 -- pdoc
 if (@mask & 64) <> 0
   select @sql = @sql + N'JOURNAL.PDOC_ID, '
 else
   select @sql = @sql + N'0, '
 -- docno
 if (@mask & 2) <> 0
   select @sql = @sql + N'DOCUMENTS.DOC_NO, '
 else
   select @sql = @sql + N'NULL, '
 -- name
 if (@mask & 1024) <> 0
   select @sql = @sql + N'DOCUMENTS.DOC_NAME, '
 else
   select @sql = @sql + N'NULL, '
 -- memo
 if (@mask & 2048) <> 0
   select @sql = @sql + N'DOCUMENTS.DOC_MEMO, '
 else
   select @sql = @sql + N'NULL, '

 -- reptax
 if (@mask & 512) <> 0
   select @sql = @sql + N'(select JT_ADDR1 from JRN_TAX where JRN_TAX.J_ID=JOURNAL.J_ID and JRN_TAX.TX_ID=@msc1),'
 else
   select @sql = @sql + N'NULL, '

 select @sql = @sql + N'JOURNAL.ACC_DB, JOURNAL.ACC_CR, '
 if @dst = 1 
   select @sql = @sql + N'sum(distinct JOURNAL.J_SUM), '
 else
   select @sql = @sql + N'sum(JOURNAL.J_SUM), '
 if @iscur = 1 
   begin
     if @dst = 1 
       select @sql = @sql + N'sum(distinct JRN_CRC.JC_SUM), '
     else
       select @sql = @sql + N'sum(JRN_CRC.JC_SUM), '
   end
  else
   select @sql = @sql + N'cast(0 as money), '
 if @dst = 1
   select @sql = @sql + 'sum(distinct JOURNAL.J_QTY), sum(distinct JOURNAL.JF_QTY) '
 else
   select @sql = @sql + 'sum(JOURNAL.J_QTY), sum(JOURNAL.JF_QTY) '
 return @sql
end
