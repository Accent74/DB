---------------------------------------------------------------------
create procedure ap_trash_isemtpy 
@mc int
as
set nocount on
if exists(select * from DOCUMENTS where DOC_DONE >=100 and MC_ID=@mc)
  select 1
else 
  select 0

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_trash_isemtpy] TO [ap_public]
    AS [dbo];

