--------------------------------------------
create procedure ap_opprop_save
@id int,
@name nvarchar(256),
@tag nvarchar(51),
@memo nvarchar(256),
@changes int = null
as
set nocount on
begin tran
declare @last datetime
select @last = getdate()
update DOCUMENTS set 
  DOC_NAME=@name, DOC_TAG=@tag, DOC_MEMO=@memo,LAST_DATE=@last
where DOC_ID=@id
-- write to log
exec ap_log_add N'D',N'U',@id
exec ap_logdoc_add 0,@id,0,@changes
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_opprop_save] TO [ap_public]
    AS [dbo];

