-----------------------------------------
create procedure ap_right_folders
@kind int,
@uid nvarchar(129)
as
set nocount on

if @kind = 0 -- folders
  select FLD_ID, 0, FLD_NAME, 
    case when exists(select * from RIGHTS where KIND=1 and KINDID=FLD_ID and UID=@uid) then 1 else 0 end 
  from FOLDERS inner join FLD_TREE on FOLDERS.FLD_ID = FLD_TREE.ID 
  where P0=0 order by FLD_NAME

else if @kind = 1 -- accounts
  select ACC_ID, ACC_TYPE, ACC_CODE + N' ' + ACC_NAME, 
    case when exists(select * from RIGHTS where KIND=2 and KINDID=ACC_ID and UID=@uid) then 1 else 0 end
 from ACCOUNTS inner join ACC_TREE on ACCOUNTS.ACC_ID = ACC_TREE.ID 
 where P0=0 and ACC_TYPE=-1 order by ACC_NAME

else if @kind = 2 -- agents
  select AG_ID, AG_TYPE, AG_NAME,
    case when exists(select * from RIGHTS where KIND=3 and KINDID=AG_ID and UID=@uid) then 1 else 0 end
  from AGENTS inner join AG_TREE on AGENTS.AG_ID = AG_TREE.ID
  where (P0=0 and AG_TYPE=0) or (AG_ID in (select PRM_LONG from SYS_PARAMS where PRM_NAME='MY_COMPANY'))
  order by AG_NAME

else if @kind = 3 -- entities
  select ENT_ID, ENT_TYPE, ENT_NAME, 
    case when exists(select * from RIGHTS where KIND=4 and KINDID=ENT_ID and UID=@uid) then 1 else 0 end
  from ENTITIES inner join ENT_TREE on ENTITIES.ENT_ID = ENT_TREE.ID 
  where P0=0 and (ENT_TYPE=0 or ENT_TYPE=1) order by ENT_NAME

else if @kind = 4 -- miscs
  select MSC_ID, MSC_TYPE, MSC_NAME,
    case when exists(select * from RIGHTS where KIND=5 and KINDID=MSC_ID and UID=@uid) then 1 else 0 end
  from MISC inner join MISC_TREE on MISC.MSC_ID = MISC_TREE.ID 
  where P0=0 and MSC_TYPE=-1 order by MSC_NAME

else if @kind = 5 -- binder
  select BIND_ID, BIND_TYPE, BIND_NAME, 
    case when exists(select * from RIGHTS where KIND=6 and KINDID=BIND_ID and UID=@uid) then 1 else 0 end
  from BINDERS inner join BIND_TREE on BINDERS.BIND_ID = BIND_TREE.ID 
  where P0=0 and BIND_TYPE=0 order by BIND_NAME

else if @kind = 6 -- templates
  select TML_ID, TML_TYPE, TML_NAME, 
    case when exists(select * from RIGHTS where KIND=7 and KINDID=TML_ID and UID=@uid) then 1 else 0 end
  from TEMPLATES inner join TML_TREE on TEMPLATES.TML_ID = TML_TREE.ID
  where P0=0 and TML_TYPE=0 order by TML_NAME


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_right_folders] TO [ap_public]
    AS [dbo];

