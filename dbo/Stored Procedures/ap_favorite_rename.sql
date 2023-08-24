----------------------------------------
create procedure ap_favorite_rename 
@id int, @name nvarchar(256)
as
set nocount on
update FAVORITES set F_NAME=@name where F_ID=@id

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_favorite_rename] TO [ap_public]
    AS [dbo];

