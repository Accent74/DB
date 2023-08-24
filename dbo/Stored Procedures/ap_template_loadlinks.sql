----------------------------------------
create procedure ap_template_loadlinks
@id int
as
set nocount on
select TML_ID_LEFT, TML_ID_RIGHT from TML_LINKS
where TML_ID_LEFT=@id or TML_ID_RIGHT=@id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_template_loadlinks] TO [ap_public]
    AS [dbo];

