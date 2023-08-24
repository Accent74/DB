----------------------------------------
create procedure ap_template_form
@frm int,
@design bit
as
set nocount on
if @design = 1
	select TML_ID,TML_TYPE,TML_NAME,TML_TAG,TML_MEMO
	from TEMPLATES where FRM_ID=@frm order by TML_NAME
else
	select TML_ID,TML_TYPE,TML_NAME,TML_TAG,TML_MEMO
	from TEMPLATES where FRM_ID=@frm and TML_HIDDEN=0 
	order by TML_NAME

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_template_form] TO [ap_public]
    AS [dbo];

