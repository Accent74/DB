-----------------------------------------
create function [dbo].[afn_rw_where] 
(@mask int, @iscur smallint, @trn smallint, @sub smallint, @mc int, @et int, @rcs smallint, @excl int)  
returns nvarchar(4000) 
as  
begin
 declare @sql nvarchar(4000)
 select @sql =  N' where JOURNAL.J_DONE=2 '   
 -- subaccounts
 if @sub = 1 
   select @sql = @sql + N'and (JOURNAL.ACC_DB=@acc or JOURNAL.ACC_CR=@acc or AD.P0=@acc or AD.P1=@acc or AD.P2=@acc or AD.P3=@acc or AD.P4=@acc or AD.P5=@acc or AD.P6=@acc or AD.P7=@acc or AC.P0=@acc or AC.P1=@acc or AC.P2=@acc or AC.P3=@acc or AC.P4=@acc or AC.P5=@acc or AC.P6=@acc or AC.P7=@acc)'
  else
   select @sql = @sql + N'and (JOURNAL.ACC_DB=@acc or JOURNAL.ACC_CR=@acc) '
 -- turns
 if @trn = 1 
   select @sql = @sql + N'and JOURNAL.J_DATE>=@sd and JOURNAL.J_DATE<@ed '
 else
   select @sql = @sql + N'and JOURNAL.J_DATE<@sd '
 -- currency 
 if @iscur = 1 
   select @sql = @sql + N'and JRN_CRC.CRC_ID=@crc '
 -- element type
 if @rcs = 1 -- recursive
   select @sql = @sql + 
    case @et
      when 2 /* agent */ then N'and (JOURNAL.J_AG1=@eid or JOURNAL.J_AG2=@eid or A1.P0=@eid or A1.P1=@eid or A1.P2=@eid or A1.P3=@eid or A1.P4=@eid or A1.P5=@eid or A1.P6=@eid or A1.P7=@eid or A2.P0=@eid or A2.P1=@eid or A2.P2=@eid or A2.P3=@eid or A2.P4=@eid or A2.P5=@eid or A2.P6=@eid or A2.P7=@eid) '
      when 3 /* entity*/ then N'and (JOURNAL.J_ENT=@eid or T.P0=@eid or T.P1=@eid or T.P2=@eid or T.P3=@eid or T.P4=@eid or T.P5=@eid or T.P6=@eid or T.P7=@eid) '
      when 4 /* misc  */ then N'and JRN_MISC.MSC_NO=@msc2 and (JRN_MISC.MSC_ID=@eid or T.P0=@eid or T.P1=@eid or T.P2=@eid or T.P3=@eid or T.P4=@eid or T.P5=@eid or T.P6=@eid or T.P7=@eid) '
      when 5 /* binder*/ then N'and JOURNAL.DOC_ID in (select DOC_ID from BIND_DOCS inner join BIND_TREE as B on BIND_DOCS.BIND_ID=B.ID where BIND_DOCS.BIND_ID=@eid or B.P0=@eid or B.P1=@eid or B.P2=@eid or B.P3=@eid or B.P4=@eid or B.P5=@eid or B.P6=@eid or B.P7=@eid) '
      else N''
    end
 else -- no  recursive
   select @sql = @sql +
    case @et 
       when 2 /*agent */ then N'and (JOURNAL.J_AG1=@eid or JOURNAL.J_AG2=@eid) '
       when 3 /*entity*/ then N'and JOURNAL.J_ENT=@eid '
       when 4 /*misc  */ then N'and JRN_MISC.MSC_ID=@eid and JRN_MISC.MSC_NO=@msc2 '
       when 5 /*binder*/ then N'and JOURNAL.DOC_ID in (select DOC_ID from BIND_DOCS where BIND_ID=@eid) '
       else N''
    end -- case
 -- mycompany
 if @mc <> 0
   select @sql = @sql + N'and JOURNAL.MC_ID=@mc '
 if @excl <> 0
   select @sql = @sql + N'and JOURNAL.DOC_ID<>@excl '
 return @sql
end
