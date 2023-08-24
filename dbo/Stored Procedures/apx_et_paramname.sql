----------------------------------------
create procedure apx_et_paramname
@et int,
@value nvarchar(65) = null out
as
set nocount on
select @value = 
case
  when @et=0 then N'FLD_PARAM_NAMES'
  when @et=1 then N'ACC_PARAM_NAMES'
  when @et=2 then N'AG_PARAM_NAMES'
  when @et=3 then N'ENT_PARAM_NAMES'
  when @et=4 then N'MISC_PARAM_NAMES'
  when @et=5 then N'BIND_PARAM_NAMES'
  when @et=6 then N'TML_PARAM_NAMES'
  when @et=7 then N'MTD_PARAM_NAMES'
  -- skip 8
  when @et=9 then N'DOC_PARAM_NAMES'
  when @et=10 then N'JRN_PARAM_NAMES'
  when @et=11 then N'DB_PARAM_NAMES'
  when @et=14 then N'FRM_PARAM_NAMES'
  when @et=16 then N'SER_PARAM_NAMES'
  -- skip 17-19
  when @et=20 then N'RCP_PARAM_NAMES'
  when @et=21 then N'RPE_PARAM_NAMES'
  -- skip 22
  when @et=23 then N'P_JRN_PARAM_NAMES'
  else null
end

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[apx_et_paramname] TO [ap_public]
    AS [dbo];

