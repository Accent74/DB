----------------------------------------
create procedure ap_agent_tree 
@p0 int, @p1 int, @p2 int, @p3 int,
@p4 int, @p5 int, @p6 int, @p7 int,
@am bit, -- admin mode
@uid nvarchar(20), -- user ID
@sm smallint, -- sort mode
@flags int = 0
as

set nocount on

declare @sql nvarchar(4000)
declare @prm nvarchar(500)
declare @fo bit
if (0x0002 & @flags) <> 0 -- folders only
  select @fo = 1
else 
  select @fo = 0
 
select @prm = N'@p0 int, @p1 int, @p2 int, @p3 int, @p4 int, @p5 int, @p6 int, @p7 int, @uid nvarchar(20)'

select @sql = N'select AGENTS.AG_ID, ' +
case @fo
when 0 then 
  N'case when exists(select * from AG_TREE AS T WHERE AGENTS.AG_ID=T.P0) then 1 else 0 end, '
when 1 then
  N'case when exists (select * from AG_TREE AS T inner join AGENTS as L on ' + 
  N'L.AG_ID = T.ID WHERE T.P0=AGENTS.AG_ID AND L.AG_TYPE=0) then 1 else 0 end, '
end +
N'AGENTS.AG_NAME, AGENTS.AG_TAG, AGENTS.AG_TYPE, AGENTS.AG_CODE, ' +
N'AGENTS.AG_TABNO, AGENTS.AG_VATNO, AGENTS.AG_ACC_X, AGENTS.AG_DATE1, AGENTS.AG_DATE2, AG_TREE.SHORTCUT ' + 
N'from AGENTS left join AG_TREE on AGENTS.AG_ID = AG_TREE.ID ' + 
N'where (P0=@p0 AND P1=@p1 AND P2=@p2 AND P3=@p3 AND ' + 
N'P4=@p4 AND P5=@p5 AND P6=@p6 AND P7=@p7)'

if @fo = 1 -- folder only
  select @sql = @sql + N' and (AGENTS.AG_TYPE = 0) '
-- sort mode : 0-nothing, 1-name, 2-tag
select @sql = @sql + 
case @sm
  when 1 then N'order by AGENTS.AG_TYPE, AGENTS.AG_NAME'
  when 2 then N'order by AGENTS.AG_TYPE, AGENTS.AG_TAG, AGENTS.AG_NAME'
  else N''
end

execute sp_executesql @sql, @prm, @p0, @p1, @p2, @p3, @p4, @p5, @p6, @p7, @uid


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_agent_tree] TO [ap_public]
    AS [dbo];

