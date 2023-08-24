---------------------------------------------
CREATE procedure ap_rep_synth1
@acc int,
@crc int,
@sd datetime
as
set nocount on

if @crc = 1
  select sum(J_SUM) as DBS, cast(0 as money) as CRS 
  from JOURNAL where ACC_DB=@acc and J_DATE < @sd and J_DONE=2 
  union
  select cast(0 as money) as DBS, sum(J_SUM) AS CRS 
  from JOURNAL where ACC_CR=@acc AND J_DATE <@sd and J_DONE=2 
else
  select sum(JC_SUM) as DBS, cast(0 as money) as CRS 
  from JOURNAL inner join JRN_CRC on JRN_CRC.J_ID = JOURNAL.J_ID
  where JRN_CRC.CRC_ID = @crc and ACC_DB=@acc and J_DATE < @sd AND J_DONE=2
  union
  select cast(0 as money) as DBS, sum(JC_SUM) as CRS 
  from JOURNAL inner join JRN_CRC on JRN_CRC.J_ID = JOURNAL.J_ID
  where JRN_CRC.CRC_ID = @crc and ACC_CR=@acc and J_DATE < @sd AND J_DONE=2


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_rep_synth1] TO [ap_public]
    AS [dbo];

