----------------------------------------
create procedure ap_price_delete
@pk int
as
set nocount on
delete from PRC_CONTENTS where PK=@pk


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_price_delete] TO [ap_public]
    AS [dbo];

