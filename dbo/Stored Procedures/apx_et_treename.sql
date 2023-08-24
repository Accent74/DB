---------------------------------------------------------------------
create procedure apx_et_treename
@et int,
@value nvarchar(65) = NULL OUT
as
set nocount on
select @value = case
  when @et=0 then N'FLD_TREE'
  when @et=1 then N'ACC_TREE'
  when @et=2 then N'AG_TREE'
  when @et=3 then N'ENT_TREE'
  when @et=4 then N'MISC_TREE'
  when @et=5 then N'BIND_TREE'
  when @et=6 then N'TML_TREE'
  when @et=7 then N'MTD_TREE'
  when @et=53 then N'JOB_TREE'
else null
end


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[apx_et_treename] TO [ap_public]
    AS [dbo];

