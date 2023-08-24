----------------------------------------
create procedure ap_right_enumflags
as
set nocount on
select UFL_ID,UFL_NAME from USR_FLAGS


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_right_enumflags] TO [ap_public]
    AS [dbo];

