----------------------------------------
create procedure ap_entity_save
@id int,
@name nvarchar(255),
@tag nvarchar(255) = null,
@memo nvarchar(255) = null,
@cat nvarchar(51) = null,
@nom nvarchar(51) = null,
@art nvarchar(51) = null,
@bar nvarchar(51) = null,
@code nvarchar(51) = null,
@un int = null,
@unself smallint = null,
@acc int = null,
@acself smallint = null
as
set nocount on
begin tran
update ENTITIES set 
  ENT_NAME=@name, ENT_TAG=@tag, ENT_MEMO=@memo,
  ENT_CAT=@cat, ENT_NOM=@nom, ENT_ART=@art, ENT_BAR=@bar, ENT_CODE=@code, 
  UN_ID=@un, ACC_ID=@acc, UN_SELF=@unself, ACC_SELF=@acself
where 
  ENT_ID=@id
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_entity_save] TO [ap_public]
    AS [dbo];

