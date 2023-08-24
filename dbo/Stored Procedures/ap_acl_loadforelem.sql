----------------------------------------
create procedure ap_acl_loadforelem
@kind int,
@id int
as
set nocount on
select UID, MASK1, MASK2, 
  case when 
    UID='_Users' or 
    exists(select * from sysusers as U where U.issqlrole=1 and U.gid <> 0 and ACL.UID=U.name) 
  then 1 else 0 end
from ACL where KIND=@kind and EL_ID=@id

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_acl_loadforelem] TO [ap_public]
    AS [dbo];

