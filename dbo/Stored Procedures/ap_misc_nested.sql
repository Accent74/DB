﻿----------------------------------------
create procedure ap_misc_nested
@id int
as
set nocount on

select MSC_ID, MSC_NAME, MSC_TAG, MSC_TYPE, MSC_NO, MSC_REF, MSC_REFID 
from MISC inner join MISC_TREE on MISC.MSC_ID=MISC_TREE.ID 
where P0=@id or P1=@id or P2=@id or P3=@id or P4=@id or P5=@id or P6=@id or P7=@id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_misc_nested] TO [ap_public]
    AS [dbo];

