----------------------------------------
create procedure ap_entity_tree 
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

select @sql = N'select ENTITIES.ENT_ID, ' +
case @fo
when 0 then 
  N'case when exists(select * from ENT_TREE AS T WHERE ENTITIES.ENT_ID=T.P0) then 1 else 0 end, '
when 1 then
  N'case when exists(select * from ENT_TREE AS T inner join ENTITIES as L on ' + 
  N'L.ENT_ID = T.ID WHERE T.P0=ENTITIES.ENT_ID AND L.ENT_TYPE<=1) then 1 else 0 end, '
end +
N'ENTITIES.ENT_NAME, ENTITIES.ENT_TAG, ENTITIES.ENT_TYPE, ' + 
N'ENTITIES.ENT_CAT, ENTITIES.ENT_NOM, ENTITIES.ENT_ART, ENTITIES.ENT_BAR, ENT_TREE.SHORTCUT, ' + 
N'ENTITIES.UN_ID, ENTITIES.UN_SELF, ENTITIES.ACC_ID, ENTITIES.ACC_SELF ' +
N'from ENTITIES left join ENT_TREE on ENTITIES.ENT_ID =ENT_TREE.ID ' + 
N'WHERE (P0=@p0 AND P1=@p1 AND P2=@p2 AND P3=@p3 AND ' + 
N'P4=@p4 AND P5=@p5 AND P6=@p6 AND P7=@p7)'

if @fo = 1 -- folder only
  select @sql = @sql + N' and (ENTITIES.ENT_TYPE <= 1) '

select @sql = @sql + N'order by ENTITIES.ENT_TYPE '

select @sql = @sql + 
case @sm
  when 1 then N', ENTITIES.ENT_NAME' -- name
  when 2 then N', ENTITIES.ENT_TAG, ENTITIES.ENT_NAME'  -- tag
  when 3 then N', ENTITIES.ENT_CAT, ENTITIES.ENT_NAME'  -- cat
  when 4 then N', ENTITIES.ENT_NOM, ENTITIES.ENT_NAME'  -- nom
  when 5 then N', ENTITIES.ENT_ART, ENTITIES.ENT_NAME'  -- art
  when 6 then N', ENTITIES.ENT_BAR, ENTITIES.ENT_NAME'  -- bar
  else N''
end

execute sp_executesql @sql, @prm, @p0, @p1, @p2, @p3, @p4, @p5, @p6, @p7, @uid


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_entity_tree] TO [ap_public]
    AS [dbo];

