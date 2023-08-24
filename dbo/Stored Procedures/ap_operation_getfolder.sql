--------------------------------------------
create procedure ap_operation_getfolder
@id int
as
declare @res int
select @res = 0
select @res = FLD_ID FROM DOCUMENTS WHERE DOC_ID=@id
return @res


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_operation_getfolder] TO [ap_public]
    AS [dbo];

