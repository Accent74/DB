----------------------------------------
create procedure ap_template_nested
@id int
as
set nocount on
select TML_ID,TML_TYPE,TML_NAME,TML_TAG,TML_MEMO, FRM_ID
from TEMPLATES inner join TML_TREE on TEMPLATES.TML_ID=TML_TREE.ID
where P0=@id or P1=@id or P2=@id or P3=@id or P4=@id or P5=@id or P6=@id or P7=@id

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_template_nested] TO [ap_public]
    AS [dbo];

