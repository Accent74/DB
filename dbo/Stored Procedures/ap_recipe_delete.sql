----------------------------------------
create procedure ap_recipe_delete
@id int
as
set nocount on
delete from RECIPES where RP_ID=@id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_recipe_delete] TO [ap_public]
    AS [dbo];

