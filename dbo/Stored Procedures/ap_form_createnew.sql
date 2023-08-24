-----------------------------------------
create procedure ap_form_createnew 
@name nvarchar(256),
@type smallint,
@file nvarchar(256)
as
set nocount on
declare @id int
insert into FORMS (FRM_NAME,FRM_TYPE,FRM_FILE) VALUES (@name,@type,@file)
select @id = ident_current('FORMS')
return @id

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_form_createnew] TO [ap_public]
    AS [dbo];

