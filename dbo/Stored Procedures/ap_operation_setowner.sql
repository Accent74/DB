----------------------------------------
create procedure ap_operation_setowner
@id int,
@mcid int
as
set nocount on
begin tran
update DOCUMENTS set MC_ID=@mcid where DOC_ID=@id
update JOURNAL set MC_ID=@mcid where DOC_ID=@id
commit tran

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_operation_setowner] TO [ap_public]
    AS [dbo];

