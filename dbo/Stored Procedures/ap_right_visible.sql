----------------------------------------
create procedure ap_right_visible
@uid nvarchar(129)
as
set nocount on
select KIND,FLAGS from RIGHTS where UID=@uid AND (KIND=-1 OR KIND=-2)


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_right_visible] TO [ap_public]
    AS [dbo];

