-----------------------------------------
create procedure ap_rep_taxrep
@tx int,
@year int,
@mcid int
as
set nocount on
select month(J_DATE),JT_ADDR1, sum(J_SUM)
from JOURNAL inner join JRN_TAX on JOURNAL.J_ID=JRN_TAX.J_ID
where JOURNAL.MC_ID=@mcid and TX_ID=@tx and year(J_DATE)=@year and J_DONE=2 
group by month(J_DATE), JT_ADDR1

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_rep_taxrep] TO [ap_public]
    AS [dbo];

