----------------------------------------
create procedure ap_acl_setflag
@uid nvarchar(128),
@kind int,
@id int,
@mask1 int = 0,
@mask2 int = 0
as
set nocount on
if @mask1 = 0 and @mask2 = 0
begin
  delete from ACL where UID=@uid and KIND=@kind and EL_ID=@id
end
else
begin
  if exists(select * from ACL where UID=@uid and KIND=@kind and EL_ID=@id)
  begin
    update ACL set MASK1=@mask1, MASK2=@mask2 where UID=@uid and KIND=@kind and EL_ID=@id
  end
  else
  begin
    insert into ACL (UID, KIND, EL_ID, MASK1, MASK2) values (@uid, @kind, @id, @mask1, @mask2)
  end
end

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_acl_setflag] TO [ap_public]
    AS [dbo];

