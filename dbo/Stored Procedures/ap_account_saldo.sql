-----------------------------------------
create procedure ap_account_saldo
@acc int,
@crc int,
@sd datetime,
@mcid int
as
set nocount on
if @crc = 1
  select sum(case ACC_DB when @acc then J_SUM else cast(0 as money) end) -
	 sum(case ACC_CR when @acc then J_SUM else cast(0 as money) end)
  from JOURNAL 
  where JOURNAL.MC_ID=@mcid and JOURNAL.J_DONE=2 and J_DATE<@sd            
else
  select sum(case ACC_DB when @acc then JC_SUM else 0 end) -
	 sum(case ACC_CR when @acc then JC_SUM else 0 end)
  from JOURNAL inner join JRN_CRC on JOURNAL.J_ID=JRN_CRC.J_ID 
  where JOURNAL.MC_ID=@mcid and JOURNAL.J_DONE=2 and J_DATE<@sd and JRN_CRC.CRC_ID=@crc


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_account_saldo] TO [ap_public]
    AS [dbo];

