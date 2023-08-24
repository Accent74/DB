----------------------------------------
create procedure ap_template_loaddocdate
@id int,
@dt datetime,
@mc int
as
set nocount on
select DOC_ID from DOCUMENTS where TML_ID=@id and DOC_DATE>=@dt and MC_ID=@mc

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_template_loaddocdate] TO [ap_public]
    AS [dbo];

