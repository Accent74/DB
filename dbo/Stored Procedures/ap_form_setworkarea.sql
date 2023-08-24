--------------------------------------------
create procedure ap_form_setworkarea
@id int
as
set nocount on
begin tran
update FORMS set FRM_TYPE=3 where FRM_TYPE=100
update FORMS set FRM_TYPE=100 where FRM_ID=@id
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_form_setworkarea] TO [ap_public]
    AS [dbo];

