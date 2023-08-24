----------------------------------------
create procedure ap_database_facts
@nt Int,
@id Int,
@dt datetime
as
Set nocount On

Select FA_ID, EL_ID, max(FA_FDATE) as FDATE 
into #factdata 
from DB_FACTS 
where EL_ID=@id And FA_FDATE<=@dt group by FA_ID, EL_ID 

Select distinct DB_FACTS.FA_ID, FA_FDATE, FA_LONG, 
       FA_STRING, FA_DOUBLE, FA_DATE, FA_CY
into #factvalues
from DB_FACTS inner Join #factdata On (DB_FACTS.EL_ID = #factdata.EL_ID) And 
(DB_FACTS.FA_FDATE = #factdata.FDATE) And (DB_FACTS.FA_ID=#factdata.FA_ID)

Select 
  DB_FACT_NAMES.FA_ID, FA_NAME, FA_TYPE, FA_FDATE,
  FA_LONG,FA_STRING,FA_DOUBLE,FA_DATE,FA_CY,DB_FACT_NAMES.FA_REF,DB_FACT_NAMES.FA_REFID, FA_DESCR
from 
  DB_FACT_NAMES Left Join #factvalues On DB_FACT_NAMES.FA_ID=#factvalues.FA_ID
where 
  NODE_TYPE=@nt

drop table #factvalues
drop table #factdata


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_database_facts] TO [ap_public]
    AS [dbo];

