----------------------------------------
create procedure ap_account_plan 
@id int
as
set nocount on
select ACC_PLAN from ACCOUNTS where ACC_ID=@id

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_account_plan] TO [ap_public]
    AS [dbo];

