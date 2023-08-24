-----------------------------------------
create procedure ap_applock 
@res nvarchar(255),
@mode nvarchar(255) = 'Exclusive',
@owner nvarchar(255) = 'Session',
@timeout int = 0
AS 
set nocount on
declare @rv int
exec @rv = sp_getapplock 
  @Resource=@res,
  @LockMode=@mode,
  @LockOwner=@owner, 
  @LockTimeout = @timeout
return @rv

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_applock] TO [ap_public]
    AS [dbo];

