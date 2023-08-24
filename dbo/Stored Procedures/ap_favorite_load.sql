----------------------------------------
create procedure ap_favorite_load 
@kind int
as
set nocount on
select F_ID, F_KIND, F_TYPE, F_REF, F_NAME from FAVORITES
	where F_TYPE=0 and F_KIND=@kind
	order by F_NAME asc

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_favorite_load] TO [ap_public]
    AS [dbo];

