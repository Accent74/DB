----------------------------------------
create procedure ap_binder_getparent 
@id int
as
  set nocount on
  select P0 from BIND_TREE where SHORTCUT=0 AND ID=@id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_binder_getparent] TO [ap_public]
    AS [dbo];

