-----------------------------------------
create procedure ap_external_create
@type smallint,
@id int,
@name nvarchar(256),
@file nvarchar(256) = null
as
set nocount on
declare @res int
begin tran
insert into EXT_DOCS (EXT_X,EXT_X_ID,EXT_NAME,EXT_FILE) values (@type,@id,@name,@file)
select @res = ident_current('EXT_DOCS')
commit tran
return @res

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_external_create] TO [ap_public]
    AS [dbo];

