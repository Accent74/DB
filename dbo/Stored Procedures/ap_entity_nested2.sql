----------------------------------------
create procedure ap_entity_nested2
@id int
as
set nocount on
select ENT_TREE.ID, ENT_TREE.P0 
from ENT_TREE inner join ENTITIES on ENTITIES.ENT_ID=ENT_TREE.ID 
where  (P0=@id or P1=@id or P2=@id or P3=@id or P4=@id or P5=@id or P6=@id or P7=@id)
and (ENTITIES.ENT_TYPE = 0 or ENTITIES.ENT_TYPE=1)


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_entity_nested2] TO [ap_public]
    AS [dbo];

