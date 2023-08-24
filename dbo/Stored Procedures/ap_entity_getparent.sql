---------------------------------------------------------------------
create procedure ap_entity_getparent 
@id int
as
  set nocount on
  select P0 from ENT_TREE where SHORTCUT=0 AND ID=@id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_entity_getparent] TO [ap_public]
    AS [dbo];

