----------------------------------------
create procedure ap_rep_synth4
@acc int,
@crc int,
@ag int,
@sd datetime,
@mcid int,
@ba int = 0
as
set nocount on

if @ag = 0
begin
if @crc = 1
  select sum(J_SUM) as DBS, cast(0 as money) as CRS 
  from JOURNAL 
  where JOURNAL.MC_ID=@mcid and ACC_DB=@acc and J_DATE < @sd and J_DONE=2 
  union
  select cast(0 as money) as DBS, sum(J_SUM) AS CRS 
  from JOURNAL 
  where JOURNAL.MC_ID=@mcid and ACC_CR=@acc AND J_DATE <@sd and J_DONE=2 
else
  select sum(JC_SUM) as DBS, cast(0 as money) as CRS 
  from JOURNAL inner join JRN_CRC on JRN_CRC.J_ID = JOURNAL.J_ID
  where JOURNAL.MC_ID=@mcid and JRN_CRC.CRC_ID = @crc and ACC_DB=@acc and J_DATE < @sd AND J_DONE=2
  union
  select cast(0 as money) as DBS, sum(JC_SUM) as CRS 
  from JOURNAL inner join JRN_CRC on JRN_CRC.J_ID = JOURNAL.J_ID
  where JOURNAL.MC_ID=@mcid and JRN_CRC.CRC_ID = @crc and ACC_CR=@acc and J_DATE < @sd AND J_DONE=2
end
else -- ag_id <> 0
begin
if @crc = 1
  if @ba = 0 
    select sum(J_SUM) as DBS, cast(0 as money) as CRS 
    from JOURNAL 
    where JOURNAL.MC_ID=@mcid and ACC_DB=@acc and J_AG1=@ag and J_DATE < @sd and J_DONE=2 
    union
    select cast(0 as money) as DBS, sum(J_SUM) AS CRS 
    from JOURNAL 
    where JOURNAL.MC_ID=@mcid and ACC_CR=@acc and J_AG2=@ag AND J_DATE <@sd and J_DONE=2 
  else -- @ba <> 0
    select sum(J_SUM) as DBS, cast(0 as money) as CRS 
    from JOURNAL 
    where JOURNAL.MC_ID=@mcid and ACC_DB=@acc and J_AG1=@ag and J_AB1=@ba and J_DATE < @sd and J_DONE=2 
    union
    select cast(0 as money) as DBS, sum(J_SUM) AS CRS 
    from JOURNAL 
    where JOURNAL.MC_ID=@mcid and ACC_CR=@acc and J_AG2=@ag and J_AB2=@ba and J_DATE <@sd and J_DONE=2 
else -- @crc <> 1
  if @ba = 0
    select sum(JC_SUM) as DBS, cast(0 as money) as CRS 
    from JOURNAL inner join JRN_CRC on JRN_CRC.J_ID = JOURNAL.J_ID
    where JOURNAL.MC_ID=@mcid and JRN_CRC.CRC_ID = @crc and ACC_DB=@acc and J_AG1=@ag and J_DATE < @sd AND J_DONE=2
    union
    select cast(0 as money) as DBS, sum(JC_SUM) as CRS 
    from JOURNAL inner join JRN_CRC on JRN_CRC.J_ID = JOURNAL.J_ID
    where JOURNAL.MC_ID=@mcid and JRN_CRC.CRC_ID = @crc and ACC_CR=@acc and J_AG2=@ag and J_DATE < @sd AND J_DONE=2
  else -- @ba <> 0
    select sum(JC_SUM) as DBS, cast(0 as money) as CRS 
    from JOURNAL inner join JRN_CRC on JRN_CRC.J_ID = JOURNAL.J_ID
    where JOURNAL.MC_ID=@mcid and JRN_CRC.CRC_ID = @crc and ACC_DB=@acc and J_AG1=@ag and J_AB1=@ba and J_DATE < @sd AND J_DONE=2
    union
    select cast(0 as money) as DBS, sum(JC_SUM) as CRS 
    from JOURNAL inner join JRN_CRC on JRN_CRC.J_ID = JOURNAL.J_ID
    where JOURNAL.MC_ID=@mcid and JRN_CRC.CRC_ID = @crc and ACC_CR=@acc and J_AG2=@ag and J_AB2=@ba and J_DATE < @sd AND J_DONE=2
end

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_rep_synth4] TO [ap_public]
    AS [dbo];

