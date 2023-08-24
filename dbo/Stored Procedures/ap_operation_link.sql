----------------------------------------
create procedure ap_operation_link
@id int,
@link int
as
set nocount on
if @link = 0
  select @link = null
update DOCUMENTS set DOC_LINK=@link where DOC_ID=@id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_operation_link] TO [ap_public]
    AS [dbo];

