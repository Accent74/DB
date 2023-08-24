----------------------------------------
create procedure ap_agent_duplicate 
@id int,
@text nvarchar(256),
@mode int
as
set nocount on
declare @cnt int
select @cnt = count(*) from AGENTS where
  case @mode
    when 0 then AG_CODE
    when 1 then AG_VATNO
    when 2 then AG_TABNO
  end
  = @text and AG_ID<>@id
return @cnt


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_agent_duplicate] TO [ap_public]
    AS [dbo];

