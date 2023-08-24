----------------------------------------
create procedure ap_right_cntusr
as
set nocount on
select count(*) from USR_FLAGS


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_right_cntusr] TO [ap_public]
    AS [dbo];

