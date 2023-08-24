----------------------------------------
create procedure ap_external_mult
@id int
as
set nocount on
begin tran
declare @type smallint
select @type = EXT_X from EXT_DOCS where EXT_ID=@id
if @type < 100
  begin
    update EXT_DOCS set EXT_X = EXT_X + 100 where EXT_ID=@id
  end
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_external_mult] TO [ap_public]
    AS [dbo];

