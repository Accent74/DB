----------------------------------------
create procedure ap_right_getmask 
@uid nvarchar(128),
@kind smallint
as
set nocount on
select KIND,FLAGS from RIGHTS 
where UID=@uid AND (KIND=-3 or (KIND >= 201 and KIND <=208))


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_right_getmask] TO [ap_public]
    AS [dbo];

