---------------------------------------------------------------------
create procedure ap_misc_getno 
@id int
as
set nocount on
declare @no int
select @no=MSC_NO from MISC where MSC_ID=@id
return @no


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_misc_getno] TO [ap_public]
    AS [dbo];

