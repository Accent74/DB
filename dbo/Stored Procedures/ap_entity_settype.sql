----------------------------------------
create procedure ap_entity_settype
@id int,
@type smallint
as
set nocount on
update ENTITIES set ENT_TYPE=@type where ENT_ID=@id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_entity_settype] TO [ap_public]
    AS [dbo];

