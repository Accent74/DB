----------------------------------------
create procedure dbo.ap_tax_trans 
@id int
as
set nocount on
select JT_KEY, TX_ID, JT_ADDR1, JT_ADDR2, JT_SIGN from JRN_TAX where J_ID=@id

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_tax_trans] TO [ap_public]
    AS [dbo];

