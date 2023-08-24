---------------------------------------
create procedure ap_appunlock 
@res nvarchar(255),
@owner nvarchar(255) = N'Session'
AS 
set nocount on
declare @rv int
exec @rv = sp_releaseapplock 
  @Resource=@res,
  @LockOwner=@owner 
return @rv

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_appunlock] TO [ap_public]
    AS [dbo];

