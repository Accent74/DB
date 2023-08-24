----------------------------------------
create procedure ap_operation_setxstatus
@id int,
@xst nchar(3)
as
set nocount on
update DOCUMENTS set DOC_XSTATUS=@xst where DOC_ID=@id

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_operation_setxstatus] TO [ap_public]
    AS [dbo];

