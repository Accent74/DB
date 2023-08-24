----------------------------------------
create procedure ap_agent_facts
@nt Int,
@id Int,
@dt datetime
as
set nocount On

Select FA_ID, EL_ID, max(FA_FDATE) as FDATE 
into #factdata 
from AG_FACTS 
where EL_ID=@id And FA_FDATE<=@dt group by FA_ID, EL_ID 

select distinct AG_FACTS.FA_ID, FA_FDATE, FA_LONG, 
       FA_STRING, FA_DOUBLE, FA_DATE, FA_CY
into #factvalues
from AG_FACTS inner Join #factdata On (AG_FACTS.EL_ID = #factdata.EL_ID) And 
(AG_FACTS.FA_FDATE = #factdata.FDATE) And (AG_FACTS.FA_ID = #factdata.FA_ID)

Select 
  AG_FACT_NAMES.FA_ID, FA_NAME, FA_TYPE, FA_FDATE,
  FA_LONG,FA_STRING,FA_DOUBLE,FA_DATE,FA_CY, AG_FACT_NAMES.FA_REF, AG_FACT_NAMES.FA_REFID, FA_DESCR
from 
  AG_FACT_NAMES Left Join #factvalues On AG_FACT_NAMES.FA_ID=#factvalues.FA_ID
where 
  NODE_TYPE=@nt

drop table #factvalues
drop table #factdata


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_agent_facts] TO [ap_public]
    AS [dbo];

