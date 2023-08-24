----------------------------------------
create procedure ap_misc_ishidden
@no int
as
set nocount on
declare @rv int
select @rv=MSC_FLAGS from MISC_ATTR where MSC_NO=@no
return @rv


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_misc_ishidden] TO [ap_public]
    AS [dbo];

