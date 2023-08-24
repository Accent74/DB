----------------------------------------
create procedure ap_operation_isinbinder
@id int
as
set nocount on
declare @res int
select @res = case when exists(select * from BIND_DOCS where DOC_ID=@id) then 1 else 0 end
return @res


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_operation_isinbinder] TO [ap_public]
    AS [dbo];

