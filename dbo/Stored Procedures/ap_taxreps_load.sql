----------------------------------------
create procedure dbo.ap_taxreps_load
@id int = 0
as
set nocount on
if @id = 0
begin
  select TX_ID, TX_NAME, TX_PERIOD, TX_TAG, TX_MEMO, TX_FILE from TAX_REPS order by TX_NAME
end
else
begin
  select TX_ID, TX_NAME, TX_PERIOD, TX_TAG, TX_MEMO, TX_FILE from TAX_REPS where TX_ID=@id
end


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_taxreps_load] TO [ap_public]
    AS [dbo];

