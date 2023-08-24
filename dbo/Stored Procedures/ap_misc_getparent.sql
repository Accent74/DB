----------------------------------------
create procedure ap_misc_getparent 
@id int
as
  set nocount on
  select P0 from MISC_TREE where SHORTCUT=0 AND ID=@id



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_misc_getparent] TO [ap_public]
    AS [dbo];

