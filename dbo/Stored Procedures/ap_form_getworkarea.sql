----------------------------------------
create procedure ap_form_getworkarea
as
set nocount on
select FRM_FILE from FORMS where FRM_TYPE=100


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_form_getworkarea] TO [ap_public]
    AS [dbo];

