----------------------------------------
create procedure ap_favorite_delete 
@id int
as
set nocount on
delete from FAVORITES where F_PARENT=@id -- все дочерние
delete from FAVORITES where F_ID=@id -- сама папка

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_favorite_delete] TO [ap_public]
    AS [dbo];

