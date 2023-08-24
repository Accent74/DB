----------------------------------------
create procedure ap_right_mask
@uid nvarchar(128),
@mask int,
@kind smallint
as
set nocount on
begin tran
declare @is int 
select @is = case when exists(select * FROM RIGHTS WHERE UID=@uid and KIND=@kind) then 1 else 0 end
if @is = 0 -- not found, insert
begin
  if @mask <> 0
    insert into RIGHTS (KIND,UID,FLAGS) values (@kind,@uid,@mask)
end
else -- present
begin
if @mask = 0 -- delete
  delete from RIGHTS where UID=@uid and KIND=@kind
else
  update RIGHTS set FLAGS=@mask where UID=@uid and KIND=@kind
end
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_right_mask] TO [ap_public]
    AS [dbo];

