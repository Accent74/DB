-----------------------------------------
create procedure ap_operation_loadextext
@id int
as
set nocount on
  select DOC_EXTEXT from DOCUMENTS where DOC_ID=@id

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_operation_loadextext] TO [ap_public]
    AS [dbo];

