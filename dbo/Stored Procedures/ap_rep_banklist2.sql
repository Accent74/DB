----------------------------------------
create procedure ap_rep_banklist2
@acc int,
@crc int,
@sd datetime,
@ed datetime,
@ag int,
@mcid int,
@ba int = 0
as
set nocount on

if @ag = 0
  begin
    if @crc = 1
      select DOCUMENTS.DOC_ID,DOC_NAME,J_DATE,DOC_NO,FRM_ID,ACC_DB,ACC_CR,J_AG1,J_AG2,sum(J_SUM) 
      from JOURNAL inner join DOCUMENTS on DOCUMENTS.DOC_ID=JOURNAL.DOC_ID 
      where JOURNAL.MC_ID=@mcid and J_DONE=2 and (ACC_DB=@acc or ACC_CR=@acc) and J_DATE>=@sd and J_DATE<@ed 
      group by DOCUMENTS.DOC_ID,DOC_NAME,J_DATE,DOC_NO,FRM_ID,ACC_DB,ACC_CR,J_AG1,J_AG2 
      order by JOURNAL.J_DATE
    else
      select DOCUMENTS.DOC_ID,DOC_NAME,J_DATE,DOC_NO,FRM_ID,ACC_DB,ACC_CR,J_AG1,J_AG2,sum(JC_SUM) 
      from (JOURNAL inner join DOCUMENTS on DOCUMENTS.DOC_ID=JOURNAL.DOC_ID) inner join JRN_CRC on JRN_CRC.J_ID=JOURNAL.J_ID
      where JOURNAL.MC_ID=@mcid and J_DONE=2 and (ACC_DB=@acc or ACC_CR=@acc) and J_DATE>=@sd and J_DATE<@ed and JRN_CRC.CRC_ID=@crc
      group by DOCUMENTS.DOC_ID,DOC_NAME,J_DATE,DOC_NO,FRM_ID,ACC_DB,ACC_CR,J_AG1,J_AG2
      order by JOURNAL.J_DATE
    end
else -- ag <> 0
  begin
    if @crc = 1
      if @ba = 0
        select DOCUMENTS.DOC_ID,DOC_NAME,J_DATE,DOC_NO,FRM_ID,ACC_DB,ACC_CR,J_AG1,J_AG2,sum(J_SUM) 
        from JOURNAL inner join DOCUMENTS on DOCUMENTS.DOC_ID=JOURNAL.DOC_ID 
        where JOURNAL.MC_ID=@mcid and J_DONE=2 and (ACC_DB=@acc and J_AG1=@ag or ACC_CR=@acc and J_AG2=@ag) and J_DATE>=@sd and J_DATE<@ed 
        group by DOCUMENTS.DOC_ID,DOC_NAME,J_DATE,DOC_NO,FRM_ID,ACC_DB,ACC_CR,J_AG1,J_AG2 
        order by JOURNAL.J_DATE
      else -- @ba <> 0
        select DOCUMENTS.DOC_ID,DOC_NAME,J_DATE,DOC_NO,FRM_ID,ACC_DB,ACC_CR,J_AG1,J_AG2,sum(J_SUM) 
        from JOURNAL inner join DOCUMENTS on DOCUMENTS.DOC_ID=JOURNAL.DOC_ID 
        where JOURNAL.MC_ID=@mcid and J_DONE=2 and (ACC_DB=@acc and J_AG1=@ag and J_AB1=@ba or ACC_CR=@acc and J_AG2=@ag and J_AB2=@ba) and J_DATE>=@sd and J_DATE<@ed 
        group by DOCUMENTS.DOC_ID,DOC_NAME,J_DATE,DOC_NO,FRM_ID,ACC_DB,ACC_CR,J_AG1,J_AG2 
        order by JOURNAL.J_DATE
    else -- @crc <> 0
      if @ba = 0
        select DOCUMENTS.DOC_ID,DOC_NAME,J_DATE,DOC_NO,FRM_ID,ACC_DB,ACC_CR,J_AG1,J_AG2,sum(JC_SUM) 
        from (JOURNAL inner join DOCUMENTS on DOCUMENTS.DOC_ID=JOURNAL.DOC_ID) inner join JRN_CRC on JRN_CRC.J_ID=JOURNAL.J_ID
        where JOURNAL.MC_ID=@mcid and J_DONE=2 and (ACC_DB=@acc and J_AG1=@ag or ACC_CR=@acc and J_AG2=@ag) and J_DATE>=@sd and J_DATE<@ed and JRN_CRC.CRC_ID=@crc
        group by DOCUMENTS.DOC_ID,DOC_NAME,J_DATE,DOC_NO,FRM_ID,ACC_DB,ACC_CR,J_AG1,J_AG2
        order by JOURNAL.J_DATE
      else -- @ba <> 0
        select DOCUMENTS.DOC_ID,DOC_NAME,J_DATE,DOC_NO,FRM_ID,ACC_DB,ACC_CR,J_AG1,J_AG2,sum(JC_SUM) 
        from (JOURNAL inner join DOCUMENTS on DOCUMENTS.DOC_ID=JOURNAL.DOC_ID) inner join JRN_CRC on JRN_CRC.J_ID=JOURNAL.J_ID
        where JOURNAL.MC_ID=@mcid and J_DONE=2 and (ACC_DB=@acc and J_AG1=@ag and J_AB1=@ba or ACC_CR=@acc and J_AG2=@ag and J_AB2=@ba) and J_DATE>=@sd and J_DATE<@ed and JRN_CRC.CRC_ID=@crc
        group by DOCUMENTS.DOC_ID,DOC_NAME,J_DATE,DOC_NO,FRM_ID,ACC_DB,ACC_CR,J_AG1,J_AG2
        order by JOURNAL.J_DATE
    end

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_rep_banklist2] TO [ap_public]
    AS [dbo];

