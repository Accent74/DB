----------------------------------------
create procedure ap_form_rename 
@id int, @name nvarchar(256)
as
set nocount on
begin tran
update FORMS set FRM_NAME=@name where FRM_ID=@id
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_form_rename] TO [ap_public]
    AS [dbo];

