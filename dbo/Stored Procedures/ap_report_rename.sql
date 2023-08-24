----------------------------------------
create procedure ap_report_rename 
@id int, @name nvarchar(256)
as
set nocount on
begin tran
update REPORTS set REP_NAME=@name where REP_ID=@id
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_report_rename] TO [ap_public]
    AS [dbo];

