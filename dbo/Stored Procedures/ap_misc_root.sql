----------------------------------------
create procedure ap_misc_root
@no int
as
set nocount on
declare @root int
select @root = (select MSC_ID from MISC where MSC_TYPE=-1 and MSC_NO=@no)
return @root


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_misc_root] TO [ap_public]
    AS [dbo];

