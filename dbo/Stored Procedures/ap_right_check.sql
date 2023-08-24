----------------------------------------
create procedure ap_right_check
@kind smallint,
@kindid int,
@uid nvarchar(128),
@check smallint
as
set nocount on
if @check = 1 -- insert
  insert into RIGHTS (UID,KIND,KINDID) values (@uid,@kind,@kindid)
else -- delete
  delete from RIGHTS where UID=@uid and KIND=@kind and KINDID=@kindid


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_right_check] TO [ap_public]
    AS [dbo];

