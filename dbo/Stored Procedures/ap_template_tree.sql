----------------------------------------
create procedure ap_template_tree 
@p0 int, @p1 int, @p2 int, @p3 int,
@p4 int, @p5 int, @p6 int, @p7 int,
@am bit, -- admin mode
@uid nvarchar(20), -- user ID
@sm smallint, -- sort mode
@design bit
as

set nocount on

declare @sql nvarchar(4000)
declare @prm nvarchar(500)
 
select @prm = N'@p0 int, @p1 int, @p2 int, @p3 int, @p4 int, @p5 int, @p6 int, @p7 int, @uid nvarchar(20)'

select @sql = N'select TEMPLATES.TML_ID, ' +
N'case when exists(select * from TML_TREE AS T WHERE TEMPLATES.TML_ID=T.P0) then 1 else 0 end, ' +
N'TEMPLATES.TML_NAME, TEMPLATES.TML_TAG, TEMPLATES.TML_TYPE, ' + 
N'TEMPLATES.FRM_ID, TML_TREE.SHORTCUT ' + 
N'from TEMPLATES left join TML_TREE on TEMPLATES.TML_ID =TML_TREE.ID ' + 
N'WHERE (P0=@p0 AND P1=@p1 AND P2=@p2 AND P3=@p3 AND ' + 
N'P4=@p4 AND P5=@p5 AND P6=@p6 AND P7=@p7)'

if @design = 0
	select @sql = @sql + N' and TEMPLATES.TML_HIDDEN=0 '
select @sql = @sql + N'order by TEMPLATES.TML_TYPE '

select @sql = @sql + 
case @sm
  when 1 then N', TEMPLATES.TML_NAME' -- name
  when 2 then N', TEMPLATES.TML_TAG, TEMPLATES.TML_NAME'  -- tag
  else N''
end

execute sp_executesql @sql, @prm, @p0, @p1, @p2, @p3, @p4, @p5, @p6, @p7, @uid


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_template_tree] TO [ap_public]
    AS [dbo];

