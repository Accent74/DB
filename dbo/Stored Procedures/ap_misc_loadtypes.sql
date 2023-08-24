---------------------------------------------------------------------
create procedure ap_misc_loadtypes 
@sm smallint = 0
as

set nocount on
declare @sql nvarchar(4000)

select @sql = N'select MSC_ID,MSC_NO,MSC_NAME from  MISC where  MSC_TYPE=-1'

select @sql = @sql + 
case @sm
  when 1 then N'order by MISC.MSC_NAME'
  when 2 then N'order by MISC.MSC_TAG'
  else N''
end

execute sp_executesql @sql


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_misc_loadtypes] TO [ap_public]
    AS [dbo];

