-----------------------------------------
create procedure ap_rep_taxlist
@addr nvarchar(255),
@tx int,
@crc int,
@sd datetime,
@ed datetime,
@mcid int
as
set nocount on

if @crc = 1
	select DOCUMENTS.DOC_ID,DOC_NAME,J_DATE,DOC_NO,FRM_ID,ACC_DB,ACC_CR,J_AG1,J_AG2,
	  sum(J_SUM), JRN_TAX.JT_ADDR1 
	from (JOURNAL inner join DOCUMENTS on DOCUMENTS.DOC_ID = JOURNAL.DOC_ID) 
	              inner join JRN_TAX on JOURNAL.J_ID = JRN_TAX.J_ID
	where JOURNAL.MC_ID=@mcid and J_DONE=2 and JRN_TAX.JT_ADDR1 Like @addr and J_DATE>=@sd AND J_DATE<@ed and TX_ID=@tx
	group by DOCUMENTS.DOC_ID,DOC_NAME,J_DATE,DOC_NO,FRM_ID,ACC_DB,ACC_CR,J_AG1,J_AG2,JT_ADDR1 
	order by JOURNAL.J_DATE 
else
	select DOCUMENTS.DOC_ID,DOC_NAME,J_DATE,DOC_NO,FRM_ID,ACC_DB,ACC_CR,J_AG1,J_AG2,
	  sum(JC_SUM), JRN_TAX.JT_ADDR1 
	from ((JOURNAL inner join DOCUMENTS on DOCUMENTS.DOC_ID = JOURNAL.DOC_ID) 
                       inner join JRN_CRC on JOURNAL.J_ID = JRN_CRC.J_ID)
	               inner join JRN_TAX on JOURNAL.J_ID = JRN_TAX.J_ID
	where JOURNAL.MC_ID=@mcid and JRN_CRC.CRC_ID=@crc and J_DONE=2 and JRN_TAX.JT_ADDR1 Like @addr and J_DATE>=@sd AND J_DATE<@ed and TX_ID=@tx
	group by DOCUMENTS.DOC_ID,DOC_NAME,J_DATE,DOC_NO,FRM_ID,ACC_DB,ACC_CR,J_AG1,J_AG2,JT_ADDR1 
	order by JOURNAL.J_DATE

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_rep_taxlist] TO [ap_public]
    AS [dbo];

