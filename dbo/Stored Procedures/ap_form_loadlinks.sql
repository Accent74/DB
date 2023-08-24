----------------------------------------
create procedure ap_form_loadlinks
@id int
as
set nocount on
select FRM_ID_LEFT, FRM_ID_RIGHT from FRM_LINKS
where FRM_ID_LEFT=@id or FRM_ID_RIGHT=@id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_form_loadlinks] TO [ap_public]
    AS [dbo];

