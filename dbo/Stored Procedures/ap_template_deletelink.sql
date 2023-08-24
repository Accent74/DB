----------------------------------------
create procedure ap_template_deletelink
@left int,
@right int
as
set nocount on

delete from TML_LINKS where TML_ID_LEFT=@left and TML_ID_RIGHT=@right


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_template_deletelink] TO [ap_public]
    AS [dbo];

