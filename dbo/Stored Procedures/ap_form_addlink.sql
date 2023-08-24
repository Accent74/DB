----------------------------------------
create procedure ap_form_addlink
@left int,
@right int
as
set nocount on
if not exists(select * from FRM_LINKS where FRM_ID_LEFT=@left and FRM_ID_RIGHT=@right)
  insert into FRM_LINKS (FRM_ID_LEFT,FRM_ID_RIGHT) values (@left,@right)


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_form_addlink] TO [ap_public]
    AS [dbo];

