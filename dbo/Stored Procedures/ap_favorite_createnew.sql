-----------------------------------------
create procedure ap_favorite_createnew
@name nvarchar(256),
@kind int,
@type int = 0
as
set nocount on
declare @rv int
insert into FAVORITES (F_NAME, F_KIND, F_TYPE) values (@name, @kind, @type)
select @rv = SCOPE_IDENTITY()
return @rv

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_favorite_createnew] TO [ap_public]
    AS [dbo];

