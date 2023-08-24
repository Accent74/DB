----------------------------------------
create procedure ap_document_facts
@nt Int,
@id Int,
@dt datetime
as
Set nocount On

Select FA_ID, EL_ID, max(FA_FDATE) as FDATE 
into #factdata 
from DOC_FACTS 
where EL_ID=@id And FA_FDATE<=@dt group by FA_ID, EL_ID 

Select distinct DOC_FACTS.FA_ID, FA_FDATE, FA_LONG, 
       FA_STRING, FA_DOUBLE, FA_DATE, FA_CY
into #factvalues
from DOC_FACTS inner Join #factdata On (DOC_FACTS.EL_ID = #factdata.EL_ID) And 
(DOC_FACTS.FA_FDATE = #factdata.FDATE) And (DOC_FACTS.FA_ID = #factdata.FA_ID)

Select 
  DOC_FACT_NAMES.FA_ID, FA_NAME, FA_TYPE, FA_FDATE,
  FA_LONG,FA_STRING,FA_DOUBLE,FA_DATE,FA_CY, DOC_FACT_NAMES.FA_REF, DOC_FACT_NAMES.FA_REFID, FA_DESCR
from 
  DOC_FACT_NAMES Left Join #factvalues On DOC_FACT_NAMES.FA_ID=#factvalues.FA_ID
where 
  NODE_TYPE=@nt

drop table #factvalues
drop table #factdata


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_document_facts] TO [ap_public]
    AS [dbo];

