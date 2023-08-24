----------------------------------------
create procedure ap_recipentry_load
@rp int
as
set nocount on
select RC_ID,RP_ID,ENT_ID,RC_QTY,RC_PERCENT,RC_TAG,AG_ID from RP_CONTENTS where RP_ID=@rp

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_recipentry_load] TO [ap_public]
    AS [dbo];

