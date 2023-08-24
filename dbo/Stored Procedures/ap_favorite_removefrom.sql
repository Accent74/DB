----------------------------------------
create procedure ap_favorite_removefrom 
@id int,
@parent int,
@kind int
as
set nocount on
delete from FAVORITES where F_REF=@id and F_PARENT=@parent and F_KIND=@kind

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_favorite_removefrom] TO [ap_public]
    AS [dbo];

