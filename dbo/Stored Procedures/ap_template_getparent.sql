-----------------------------------------
create procedure ap_template_getparent 
@id int
as
  
set nocount on
select P0 from TML_TREE where SHORTCUT=0 AND ID=@id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_template_getparent] TO [ap_public]
    AS [dbo];

