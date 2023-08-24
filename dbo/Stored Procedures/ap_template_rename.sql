---------------------------------------------------------------------
create procedure ap_template_rename 
@id int, @name nvarchar(256)
as
set nocount on
begin tran
update TEMPLATES set TML_NAME=@name where TML_ID=@id
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_template_rename] TO [ap_public]
    AS [dbo];

