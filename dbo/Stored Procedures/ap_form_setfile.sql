----------------------------------------
create procedure ap_form_setfile 
@id int, @name nvarchar(256)
as
set nocount on
begin tran
update FORMS set FRM_FILE=@name where FRM_ID=@id
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_form_setfile] TO [ap_public]
    AS [dbo];

