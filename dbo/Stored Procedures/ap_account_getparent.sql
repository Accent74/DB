----------------------------------------
create procedure ap_account_getparent 
@id int
as
set nocount on
select P0 from ACC_TREE where SHORTCUT=0 AND ID=@id

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_account_getparent] TO [ap_public]
    AS [dbo];

