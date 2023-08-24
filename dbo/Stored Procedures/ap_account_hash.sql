-------------------------------------------
create procedure ap_account_hash
@plan int
as
set nocount on
if @plan = 0
  begin
    select ACC_ID,ACC_CODE,ACC_PLAN,ACC_TYPE from ACCOUNTS
  end
else
  begin
    select ACC_ID,ACC_CODE,ACC_PLAN,ACC_TYPE from ACCOUNTS where ACC_PLAN=@plan
  end


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_account_hash] TO [ap_public]
    AS [dbo];

