----------------------------------------
create procedure ap_misc_load7 
@p1 int,
@p2 int = 0,
@p3 int = 0,
@p4 int = 0,
@p5 int = 0,
@p6 int = 0,
@p7 int = 0
as
set nocount on
select 
  MSC_ID,MSC_NAME,MSC_TAG,MSC_TYPE,MSC_NO,MSC_REF,MSC_REFID
from 
  MISC 
where 
  MSC_ID=@p1 or MSC_ID=@p2 or MSC_ID=@p3 or MSC_ID=@p4 or
  MSC_ID=@p5 or MSC_ID=@p6 or MSC_ID=@p7


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_misc_load7] TO [ap_public]
    AS [dbo];

