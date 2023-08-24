----------------------------------------
create procedure ap_folder_tree 
@p0 int, @p1 int, @p2 int, @p3 int,
@p4 int, @p5 int, @p6 int, @p7 int
as
set nocount on
select FOLDERS.FLD_ID, 
  case when exists(select *  from FLD_TREE as T where FLD_ID=T.P0) then 1 else 0 end, 
  FOLDERS.FLD_NAME, FOLDERS.FLD_TAG, FOLDERS.TML_ID, FOLDERS.FRM_ID,FLD_TREE.SHORTCUT,
  FOLDERS.FLD_MEMO, FOLDERS.FLD_SYSCODE 
from FOLDERS left join FLD_TREE on FOLDERS.FLD_ID = FLD_TREE.ID 
where (P0=@p0 and P1=@p1 and P2=@p2 and P3=@p3 and P4=@p4 and P5=@p5 and P6=@p6 and P7=@p7)

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_folder_tree] TO [ap_public]
    AS [dbo];

