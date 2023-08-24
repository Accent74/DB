----------------------------------------
create procedure ap_entity_nested
@id int
as
set nocount on
select 
  ENT_ID,ENT_TYPE,ENT_NAME,ENT_TAG,ENT_CAT,ENT_NOM,ENT_ART,ENT_BAR,ENT_CODE
from 
  ENTITIES inner join ENT_TREE on ENTITIES.ENT_ID=ENT_TREE.ID
where 
  P0=@id or P1=@id or P2=@id or P3=@id or P4=@id or P5=@id or P6=@id or P7=@id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_entity_nested] TO [ap_public]
    AS [dbo];

