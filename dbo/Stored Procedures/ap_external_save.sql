--------------------------------------------
create procedure ap_external_save
@id int,
@name nvarchar(256),
@file nvarchar(256),
@memo nvarchar(256) = null
as

set nocount on

begin tran
update EXT_DOCS
set EXT_NAME=@name,EXT_FILE=@file,EXT_MEMO=@memo
where EXT_ID=@id
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_external_save] TO [ap_public]
    AS [dbo];

