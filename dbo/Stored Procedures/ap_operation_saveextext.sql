-----------------------------------------
create procedure ap_operation_saveextext
@id int,
@text ntext
as
set nocount on
update DOCUMENTS set DOC_EXTEXT=@text where DOC_ID=@id

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_operation_saveextext] TO [ap_public]
    AS [dbo];

