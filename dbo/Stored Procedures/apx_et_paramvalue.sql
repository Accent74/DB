----------------------------------------
create procedure apx_et_paramvalue
@et int,
@value nvarchar(65) = null OUT,
@field nvarchar(32) = null OUT
as
set nocount on
select @value = 
case
  when @et=0 then N'FLD_PARAMS'
  when @et=1 then N'ACC_PARAMS'
  when @et=2 then N'AG_PARAMS'
  when @et=3 then N'ENT_PARAMS'
  when @et=4 then N'MISC_PARAMS'
  when @et=5 then N'BIND_PARAMS'
  when @et=6 then N'TML_PARAMS'
  when @et=7 then N'MTD_PARAMS'
  -- 8 skip
  when @et=9 then N'DOC_PARAMS'
  when @et=10 then N'JRN_PARAMS'
  when @et=11 then N'DB_PARAMS'
  when @et=14 then N'FRM_PARAMS'
  when @et=16 then N'SER_PARAMS'
  -- 17-19 skip
  when @et=20 then N'RCP_PARAMS'
  when @et=21 then N'RPE_PARAMS'
  -- 22 skip
  when @et=23 then N'P_JRN_PARAMS'
  else null
end
  
select @field = 
case
  when @et=0 then N'FLD_ID'
  when @et=1 then N'ACC_ID'
  when @et=2 then N'AG_ID'
  when @et=3 then N'ENT_ID'
  when @et=4 then N'MSC_ID'
  when @et=5 then N'BIND_ID'
  when @et=6 then N'TML_ID'
  when @et=7 then N'MTD_ID'
  -- 8 skip
  when @et=9 then N'DOC_ID'
  when @et=10 then N'J_ID'
  when @et=11 then N'DB_ID'
  when @et=14 then N'FRM_ID'
  when @et=16 then N'SER_ID'
  -- 17-19 skip
  when @et=20 then N'RP_ID'
  when @et=21 then N'RC_ID'
  -- 22 skip
  when @et=23 then N'JP_ID'
  else null
end

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[apx_et_paramvalue] TO [ap_public]
    AS [dbo];

