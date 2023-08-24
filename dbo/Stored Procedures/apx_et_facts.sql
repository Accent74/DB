----------------------------------------
CREATE procedure apx_et_facts
@et int,
@names nvarchar(65) = null OUT,
@values nvarchar(32) = null OUT
as
set nocount on
select @names = 
case
  when @et=2  then N'AG_FACT_NAMES'
  when @et=3  then N'ENT_FACT_NAMES'
  when @et=4  then N'MISC_FACT_NAMES'
  when @et=11 then N'DB_FACT_NAMES'
  when @et=9  then N'DOC_FACT_NAMES'
  else null
end
  
select @values = 
case
  when @et=2  then N'AG_FACTS'
  when @et=3  then N'ENT_FACTS'
  when @et=4  then N'MISC_FACTS'
  when @et=11 then N'DB_FACTS'
  when @et=9  then N'DOC_FACTS'
  else null
end


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[apx_et_facts] TO [ap_public]
    AS [dbo];

