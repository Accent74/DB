----------------------------------------
create procedure ap_misc_load 
@id int
as
set nocount on
select 
  MSC_TYPE,MSC_NO,MSC_NAME,MSC_TAG,MSC_MEMO,
  MSC_STR1,MSC_STR2,MSC_STR3,MSC_LNG1,MSC_LNG2,MSC_LNG3,
  MSC_CY1,MSC_CY2,MSC_CY3,MSC_DT1,MSC_DT2,MSC_DT3,MSC_REF,MSC_REFID,MSC_GUID
from MISC where MSC_ID=@id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_misc_load] TO [ap_public]
    AS [dbo];

