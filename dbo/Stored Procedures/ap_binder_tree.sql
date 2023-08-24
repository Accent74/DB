----------------------------------------
create procedure ap_binder_tree 
@p0 int = 0, 
@p1 int = 0, 
@p2 int = 0, 
@p3 int = 0,
@p4 int = 0, 
@p5 int = 0, 
@p6 int = 0, 
@p7 int = 0,
@am bit = 1, -- admin mode: 1-admin, 0-user
@uid nvarchar(20) = null, -- user ID
@sm smallint = 0-- sort mode : 0-nothing, 1-name, 2-tag
as

set nocount on

declare @sql nvarchar(4000)
declare @prm nvarchar(500)
 
select @prm = N'@p0 int, @p1 int, @p2 int, @p3 int, @p4 int, @p5 int, @p6 int, @p7 int, @uid nvarchar(20)'

select @sql = N'select BINDERS.BIND_ID, ' +
N'case when exists(select * from BIND_TREE AS T WHERE BINDERS.BIND_ID=T.P0) then 1 else 0 end, ' +
N'BINDERS.BIND_NAME,BINDERS.BIND_TAG, BINDERS.BIND_TYPE, BIND_TREE.SHORTCUT ' + 
N'from BINDERS left join BIND_TREE on BINDERS.BIND_ID = BIND_TREE.ID ' + 
N'WHERE (P0=@p0 AND P1=@p1 AND P2=@p2 AND P3=@p3 AND ' + 
N'P4=@p4 AND P5=@p5 AND P6=@p6 AND P7=@p7)'

-- sort mode : 0-nothing, 1-name, 2-tag
select @sql = @sql + 
case @sm
  when 1 then N'order by BINDERS.BIND_TYPE, BINDERS.BIND_NAME'
  when 2 then N'order by BINDERS.BIND_TYPE, BINDERS.BIND_TAG, BINDERS.BIND_NAME'
  else N''
end

execute sp_executesql @sql, @prm, @p0, @p1, @p2, @p3, @p4, @p5, @p6, @p7, @uid


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_binder_tree] TO [ap_public]
    AS [dbo];

