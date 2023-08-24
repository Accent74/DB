--------------------------------------------
create procedure ap_operation_move
@id int,
@parent int
as
set nocount on
declare @px int
select @px = @parent
if @px = 0
  select @px = null
update DOCUMENTS set FLD_ID=@px where DOC_ID=@id

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_operation_move] TO [ap_public]
    AS [dbo];

