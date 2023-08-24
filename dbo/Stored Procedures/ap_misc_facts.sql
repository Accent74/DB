----------------------------------------
create procedure ap_misc_facts
@nt Int,
@id Int,
@dt datetime
as
Set nocount On

Select FA_ID, EL_ID, max(FA_FDATE) as FDATE 
into #factdata 
from MISC_FACTS 
where EL_ID=@id And FA_FDATE<=@dt group by FA_ID, EL_ID 

Select distinct MISC_FACTS.FA_ID, FA_FDATE, FA_LONG, 
       FA_STRING, FA_DOUBLE, FA_DATE, FA_CY
into #factvalues
from MISC_FACTS inner Join #factdata On (MISC_FACTS.EL_ID = #factdata.EL_ID) And 
(MISC_FACTS.FA_FDATE = #factdata.FDATE) And (MISC_FACTS.FA_ID = #factdata.FA_ID)

Select 
  MISC_FACT_NAMES.FA_ID, FA_NAME, FA_TYPE, FA_FDATE,
  FA_LONG,FA_STRING,FA_DOUBLE,FA_DATE,FA_CY,MISC_FACT_NAMES.FA_REF,MISC_FACT_NAMES.FA_REFID, FA_DESCR
from 
  MISC_FACT_NAMES Left Join #factvalues On MISC_FACT_NAMES.FA_ID=#factvalues.FA_ID
where 
  NODE_TYPE=@nt

drop table #factvalues
drop table #factdata


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_misc_facts] TO [ap_public]
    AS [dbo];

