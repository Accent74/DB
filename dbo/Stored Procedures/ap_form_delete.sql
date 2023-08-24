----------------------------------------------------
create procedure ap_form_delete
@id int
as
set nocount on
begin tran
delete from FORMS where FRM_ID=@id
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_form_delete] TO [ap_public]
    AS [dbo];

