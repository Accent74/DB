-----------------------------------------
create procedure ap_entity_load7
@id1 int, @id2 int, @id3 int, @id4 int,
@id5 int,@id6 int,@id7 int
as
set nocount on
select 
  ENT_ID, ENT_NAME, ENT_TYPE, ENT_TAG, ENT_CAT, ENT_NOM, ENT_ART, ENT_BAR, UN_ID, UN_SELF
from 
  ENTITIES 
where 
  ENT_ID=@id1 or ENT_ID=@id2 or ENT_ID=@id3 or
  ENT_ID=@id4 or ENT_ID=@id5 or ENT_ID=@id6 or ENT_ID=@id7


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_entity_load7] TO [ap_public]
    AS [dbo];

