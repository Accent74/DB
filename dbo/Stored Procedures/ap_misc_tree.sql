----------------------------------------
create procedure ap_misc_tree 
@p0 int = 0, @p1 int = 0, @p2 int = 0, @p3 int = 0,
@p4 int = 0, @p5 int = 0, @p6 int = 0, @p7 int = 0,
@sm smallint = 0, -- sort mode
@flags int = 0
as
set nocount on
declare @sql nvarchar(4000)
declare @prm nvarchar(500)
declare @fo bit

select @prm = N'@p0 int, @p1 int, @p2 int, @p3 int, @p4 int, @p5 int, @p6 int, @p7 int'

if (0x0002 & @flags) <> 0 -- folders only
  select @fo = 1
else 
  select @fo = 0

select @sql = N'select MISC.MSC_ID, ' +
case @fo
when 0 then 
  N'case when exists(select * from MISC_TREE AS T WHERE MISC.MSC_ID=T.P0) then 1 else 0 end, '
when 1 then
  N'case when exists(select * from MISC_TREE AS T inner join MISC as L on T.ID=L.MSC_ID ' +
  N'where MISC.MSC_ID=T.P0 and L.MSC_TYPE=0) then 1 else 0 end, '
end +
N'MISC.MSC_NAME, MISC.MSC_TAG, MISC.MSC_TYPE, MISC.MSC_NO,MISC_TREE.SHORTCUT, ' + 
N'MISC.MSC_REF, MISC.MSC_REFID ' +
N'from MISC left join MISC_TREE on MISC.MSC_ID = MISC_TREE.ID ' +
N'where (P0=@p0 and P1=@p1 and P2=@p2 and P3=@p3 and ' + 
N'P4=@p4 and P5=@p5 and P6=@p6 and P7=@p7)'
if @fo = 1 -- folder only
  select @sql = @sql + N' and (MISC.MSC_TYPE = 0) '

-- sort mode : 0-nothing, 1-name, 2-tag
select @sql = @sql + 
case @sm
  when 1 then N'order by MISC.MSC_TYPE, MISC.MSC_REF, MISC.MSC_NAME'
  when 2 then N'order by MISC.MSC_TYPE, MISC.MSC_REF, MISC.MSC_TAG, MISC.MSC_NAME'
  else N''
end
execute sp_executesql @sql, @prm, @p0, @p1, @p2, @p3, @p4, @p5, @p6, @p7

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_misc_tree] TO [ap_public]
    AS [dbo];

