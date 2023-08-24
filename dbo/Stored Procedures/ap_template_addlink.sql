----------------------------------------
create procedure ap_template_addlink
@left int,
@right int
as
set nocount on
if not exists(select * from TML_LINKS where TML_ID_LEFT=@left and TML_ID_RIGHT=@right)
  insert into TML_LINKS (TML_ID_LEFT,TML_ID_RIGHT) values (@left,@right)


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_template_addlink] TO [ap_public]
    AS [dbo];

