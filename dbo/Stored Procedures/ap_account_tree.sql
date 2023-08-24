----------------------------------------
create procedure ap_account_tree 
@p0 int, @p1 int, @p2 int, @p3 int,
@p4 int, @p5 int, @p6 int, @p7 int,
@am bit, -- admin mode
@uid nvarchar(20), -- user ID
@sm smallint -- sort mode

as

set nocount on

declare @sql nvarchar(4000)
declare @prm nvarchar(500)
 
select @prm = N'@p0 int, @p1 int, @p2 int, @p3 int, @p4 int, @p5 int, @p6 int, @p7 int, @uid nvarchar(20)'

select @sql = N'select ACCOUNTS.ACC_ID, ' +
N'case when exists(select* from ACC_TREE AS T WHERE ACCOUNTS.ACC_ID=T.P0) then 1 else 0 end, ' +
N'ACCOUNTS.ACC_CODE,ACCOUNTS.ACC_PLAN, ACCOUNTS.ACC_PL_CODE,ACCOUNTS.ACC_NAME, ACCOUNTS.ACC_TYPE, ' +
N'ACCOUNTS.ACC_S_TYPE,ACCOUNTS.ACC_TAG, ACC_TREE.SHORTCUT ' + 
N'from ACCOUNTS left join ACC_TREE on ACCOUNTS.ACC_ID = ACC_TREE.ID ' + 
N'WHERE (P0=@p0 AND P1=@p1 AND P2=@p2 AND P3=@p3 AND ' + 
N'P4=@p4 AND P5=@p5 AND P6=@p6 AND P7=@p7)'

-- sort mode : 0-nothing, 1-name, 2-tag
select @sql = @sql + 
case @sm
  when 1 then N'order by ACCOUNTS.ACC_CODE, ACCOUNTS.ACC_NAME'
  when 2 then N'order by ACCOUNTS.ACC_NAME'
  when 3 then N'order by ACCOUNTS.ACC_TAG, ACCOUNTS.ACC_NAME'
  else N''
end

execute sp_executesql @sql, @prm, @p0, @p1, @p2, @p3, @p4, @p5, @p6, @p7, @uid

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_account_tree] TO [ap_public]
    AS [dbo];

