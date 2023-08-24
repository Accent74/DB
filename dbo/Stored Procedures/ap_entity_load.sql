----------------------------------------
create procedure ap_entity_load 
@id int
as
set nocount on
select 
  ENT_ID,ENT_NAME,ENT_TYPE,
  ENT_TAG,ENT_CAT,ENT_NOM,ENT_ART,ENT_BAR,ENT_MEMO,
  UN_ID,UN_SELF,ACC_ID,ACC_SELF,ENT_GUID
from 
  ENTITIES
where
  ENT_ID=@id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_entity_load] TO [ap_public]
    AS [dbo];

