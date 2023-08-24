----------------------------------------
create procedure ap_grant_torole
@role nvarchar(128)
as
set nocount on
declare @name nvarchar(128)
declare @sql  nvarchar(1024)
declare #tmpcrs cursor local fast_forward read_only for
  select cast(name as nvarchar(255)) from dbo.sysobjects where OBJECTPROPERTY(id, N'IsProcedure') = 1
open #tmpcrs
fetch next from #tmpcrs into @name
while @@fetch_status = 0
  begin
     if left(@name,2) = N'ap'
	begin
	  select @sql = N'grant execute on ' + @name + N' to ' + @role
	  exec sp_executesql @sql
	end
     fetch next from #tmpcrs into @name
  end
close #tmpcrs
deallocate #tmpcrs


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_grant_torole] TO [ap_public]
    AS [dbo];

