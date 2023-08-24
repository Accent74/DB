-----------------------------------------------
create procedure ap_folder_sys2id
@code nvarchar(256)
as
set nocount on
declare @val int
select @val = FLD_ID from FOLDERS where FLD_SYSCODE=@code
if @@rowcount = 0
  select @val = 0
return @val

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_folder_sys2id] TO [ap_public]
    AS [dbo];

