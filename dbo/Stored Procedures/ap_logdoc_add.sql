----------------------------------------
create procedure ap_logdoc_add
@mode    int,
@doc_id  int,
@j_id    int,
@changes int,
@prm1    int = null,
@prm2    int = null,
@prm3    int = null
as
set nocount on
-- всегда внутри транзакции!
declare @on nchar(2)
select @on = PRM_STR from SYS_PARAMS where PRM_NAME=N'LOGDOC'
if upper(@on) = N'ON' 
  insert into SYS_LOGDOC (ITEM,DOC_ID,J_ID,FLAGS)
  values (@mode,@doc_id,@j_id,@changes)


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_logdoc_add] TO [ap_public]
    AS [dbo];

