----------------------------------------
create procedure ap_binder_candelete 
@id int
as
set nocount on

/* check childs */
If exists(select * from BIND_TREE where BIND_TREE.P0=@id)
begin
  raiserror(N'Подшивку или папку удалить нельзя, в ней есть вложенные',16,-1)
  return 1
end
/* documents */
if exists(select * from BIND_DOCS where BIND_ID=@id)
begin
  raiserror(N'Подшивку удалить нельзя, в ней есть документы',16,-1)
  return 2
end 
return 0


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_binder_candelete] TO [ap_public]
    AS [dbo];

