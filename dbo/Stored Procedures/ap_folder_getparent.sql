---------------------------------------------------------------------
create procedure ap_folder_getparent 
@id int
as
set nocount on
select P0 from FLD_TREE where SHORTCUT=0 AND ID=@id

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_folder_getparent] TO [ap_public]
    AS [dbo];

