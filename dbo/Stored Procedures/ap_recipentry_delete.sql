----------------------------------------
create procedure ap_recipentry_delete
@rc int
as

set nocount on
delete from RP_CONTENTS where RC_ID=@rc


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_recipentry_delete] TO [ap_public]
    AS [dbo];

