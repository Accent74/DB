----------------------------------------
create procedure ap_misc_hide
@no int,
@flags int
as
set nocount on
update MISC_ATTR set MSC_FLAGS=@flags where MSC_NO=@no


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_misc_hide] TO [ap_public]
    AS [dbo];

