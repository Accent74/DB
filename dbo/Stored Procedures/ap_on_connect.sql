---------------------------------------------------------------------
create procedure ap_on_connect
@uid nvarchar(20)
as
set nocount on


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_on_connect] TO [ap_public]
    AS [dbo];

