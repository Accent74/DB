----------------------------------------
create procedure ap_entity_facts
@nt Int,
@id Int,
@dt datetime
as
Set nocount On

Select FA_ID, EL_ID, max(FA_FDATE) as FDATE 
into #factdata 
from ENT_FACTS 
where EL_ID=@id And FA_FDATE<=@dt group by FA_ID, EL_ID 

Select distinct ENT_FACTS.FA_ID, FA_FDATE, FA_LONG, 
       FA_STRING, FA_DOUBLE, FA_DATE, FA_CY
into #factvalues
from ENT_FACTS inner Join #factdata On (ENT_FACTS.EL_ID = #factdata.EL_ID) And 
(ENT_FACTS.FA_FDATE = #factdata.FDATE) And (ENT_FACTS.FA_ID = #factdata.FA_ID)

Select 
  ENT_FACT_NAMES.FA_ID, FA_NAME, FA_TYPE, FA_FDATE,
  FA_LONG,FA_STRING,FA_DOUBLE,FA_DATE,FA_CY,ENT_FACT_NAMES.FA_REF,ENT_FACT_NAMES.FA_REFID, FA_DESCR
from 
  ENT_FACT_NAMES Left Join #factvalues On ENT_FACT_NAMES.FA_ID=#factvalues.FA_ID
where 
  NODE_TYPE=@nt

drop table #factvalues
drop table #factdata


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_entity_facts] TO [ap_public]
    AS [dbo];

