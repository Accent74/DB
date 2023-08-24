---------------------------------------------------------------------
create procedure ap_template_save
@id int,
@name nvarchar(256),
@tag nvarchar(51) = null,
@memo nvarchar(256) = null,
@frm int = null,
@hidden bit = 0
as
set nocount on
update TEMPLATES set 
  TML_NAME=@name, TML_TAG=@tag, TML_MEMO=@memo, FRM_ID=@frm, TML_HIDDEN=@hidden
where TML_ID=@id

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_template_save] TO [ap_public]
    AS [dbo];

