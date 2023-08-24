--------------------------------------------
create procedure ap_external_move
@id int,
@to int
as
set nocount on
begin tran
update EXT_DOCS set EXT_X_ID=@to WHERE EXT_ID=@id
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_external_move] TO [ap_public]
    AS [dbo];

