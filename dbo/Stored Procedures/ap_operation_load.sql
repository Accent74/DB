----------------------------------------
create procedure ap_operation_load
@id int
as
set nocount on
-- первый ResultSet
select 
  DOC_ID, DOC_DATE, DOC_SUM, DOC_NAME, DOC_MEMO, DOC_TAG,
  FRM_ID, TML_ID, DOC_NO, DOC_DONE,
  DOC_PS1,DOC_PS2,DOC_PS3,DOC_PL1,DOC_PL2,DOC_PL3,DOC_PC1,DOC_PC2,DOC_PC3,DOC_PD1,DOC_PD2,DOC_PD3,
  DOC_LINK,
  case when 
    exists(select * from BIND_DOCS as T where DOCUMENTS.DOC_ID=T.DOC_ID) then 1 else 0 end,
  DOC_GUID, ST_ID, FLD_ID, DOCUMENTS.DOC_XSTATUS
from 
  DOCUMENTS
where 
  DOC_ID=@id
 -- второй ResultSet
select 
  J_ID,DOC_ID,J_TR_NO,J_LN_NO,ACC_DB,ACC_CR,J_SUM,J_QTY,J_PRICE,
  J_AG1,J_AG2,J_ENT,J_UN,JF_UN, JF_QTY, J_DATE, J_LINK, SER_ID, PDOC_ID, J_AB1, J_AB2, J_TAG,
  case when 
    exists(select * from JRN_CRC where JRN_CRC.J_ID=JOURNAL.J_ID) then 1 else 0 end
from 
  JOURNAL
where 
  DOC_ID=@id

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_operation_load] TO [ap_public]
    AS [dbo];

