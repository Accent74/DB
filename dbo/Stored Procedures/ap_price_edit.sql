----------------------------------------
create procedure ap_price_edit
@pk int,
@cy money
as
set nocount on
-- обновить цену
update PRC_CONTENTS set PRC_VALUE=@cy where PK=@pk


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_price_edit] TO [ap_public]
    AS [dbo];

