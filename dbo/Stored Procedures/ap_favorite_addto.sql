----------------------------------------
create procedure ap_favorite_addto 
@id int,
@parent int,
@kind int
as
set nocount on
if @kind = 0
	insert into FAVORITES (F_REF, F_PARENT, F_KIND, F_TYPE) values (@id, @parent, 0, 1)
else
	insert into FAVORITES (F_REF, F_PARENT, F_KIND, F_TYPE) values (@id, @parent, 1, 1)

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_favorite_addto] TO [ap_public]
    AS [dbo];

