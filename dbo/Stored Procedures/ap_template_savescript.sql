---------------------------------------------------------------------
create procedure ap_template_savescript
@id int,
@text ntext,
@form int,
@saveform smallint
as
set nocount on
begin tran
if @saveform = 1 -- save form id
  update TEMPLATES set TML_SCRIPT=@text, FRM_ID=@form where TML_ID=@id
else
  update TEMPLATES set TML_SCRIPT=@text where TML_ID=@id  
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_template_savescript] TO [ap_public]
    AS [dbo];

