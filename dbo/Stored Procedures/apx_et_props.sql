----------------------------------------
create procedure apx_et_props
@et int,
@cats  nvarchar(65) = null OUT,
@names nvarchar(65) = null OUT,
@values nvarchar(32) = null OUT
as
set nocount on
select @cats =
case 
  when @et=2  then N'AG_PROP_CATEGORY'
  when @et=11 then N'DB_PROP_CATEGORY'
  else null
end
select @names = 
case
  when @et=2  then N'AG_PROP_NAMES'
  when @et=11 then N'DB_PROP_NAMES'
  else null
end
  
select @values = 
case
  when @et=2  then N'AG_PROPS'
  when @et=11 then N'DB_PROPS'
  else null
end

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[apx_et_props] TO [ap_public]
    AS [dbo];

