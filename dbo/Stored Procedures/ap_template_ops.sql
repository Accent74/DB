----------------------------------------
create procedure ap_template_ops 
@id int,
@mc int
as
set nocount on
select count(*) from DOCUMENTS where TML_ID=@id and MC_ID=@mc

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_template_ops] TO [ap_public]
    AS [dbo];

