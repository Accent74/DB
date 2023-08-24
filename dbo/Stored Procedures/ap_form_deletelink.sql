----------------------------------------
create procedure ap_form_deletelink
@left int,
@right int
as
set nocount on

delete from FRM_LINKS where FRM_ID_LEFT=@left and FRM_ID_RIGHT=@right


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_form_deletelink] TO [ap_public]
    AS [dbo];

