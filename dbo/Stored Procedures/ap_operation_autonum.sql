---------------------------------------------
create procedure ap_operation_autonum
@fa int
as 
set nocount on
declare @res nvarchar(256)
set transaction isolation level serializable
begin tran
declare @p nvarchar(256)
declare @s nvarchar(256)
declare @c int
update FRM_AUTONUM set AN_CURRENT=AN_CURRENT+1 where FA_ID=@fa
select @p=AN_PREFIX,@s=AN_SUFFIX,@c=AN_CURRENT 
	from FRM_AUTONUM where FA_ID=@fa
commit tran
set transaction isolation level read committed
select @res = isnull(@p,N'') + convert(nvarchar(32),isnull(@c,1)) + isnull(@s,N'')
select @res


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_operation_autonum] TO [ap_public]
    AS [dbo];

