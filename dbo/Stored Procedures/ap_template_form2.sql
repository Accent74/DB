----------------------------------------
create procedure ap_template_form2
@frm int,
@design bit
as
set nocount on
if @design = 1
	select TML_ID,TML_TYPE,TML_NAME,TML_TAG,TML_MEMO,
	P0, P1, P2, P3, P4, P5, P6, P7
	from TEMPLATES inner join TML_TREE on TEMPLATES.TML_ID=TML_TREE.ID
	where FRM_ID=@frm and TML_TREE.SHORTCUT<>1 order by TML_NAME
else
	select TML_ID,TML_TYPE,TML_NAME,TML_TAG,TML_MEMO,
	P0, P1, P2, P3, P4, P5, P6, P7
	from TEMPLATES inner join TML_TREE on TEMPLATES.TML_ID=TML_TREE.ID
	where FRM_ID=@frm and TML_HIDDEN=0 and TML_TREE.SHORTCUT<>1 order by TML_NAME

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_template_form2] TO [ap_public]
    AS [dbo];

