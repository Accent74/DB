----------------------------------------
create procedure ap_right_getflag
@uid nvarchar(128),
@kind smallint
as
set nocount on
select KIND, FLAGS from RIGHTS 
where UID=@uid and KIND=@kind


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_right_getflag] TO [ap_public]
    AS [dbo];

