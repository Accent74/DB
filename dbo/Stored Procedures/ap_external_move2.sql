----------------------------------------
create procedure ap_external_move2
@type smallint,
@id int,
@to int
as
set nocount on
begin tran
update EXT_DOCS set EXT_X=@type, EXT_X_ID=@to WHERE EXT_ID=@id
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_external_move2] TO [ap_public]
    AS [dbo];

