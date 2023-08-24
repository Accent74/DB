-----------------------------------------
create procedure ap_param_addname
@et int,
@name nvarchar(256),
@type smallint,
@node smallint,
@ref int,
@refid int,
@descr nvarchar(256) = null
as
set nocount on
begin tran
if @ref = 0
  select @ref = null
if @refid = 0
  select @refid = null
declare @tbl nvarchar(64)
declare @sql nvarchar(255)
declare @rv int
declare @prm nvarchar(255)
 
exec apx_et_paramname @et, @tbl OUT
if @tbl is null
  begin
    rollback tran
    raiserror (N'Недопустимый тип параметра',16,-1)
    return 0
  end
  
select @sql = N'INSERT INTO ' + 
	      @tbl + 
	      N' (PRM_NAME,PRM_TYPE,NODE_TYPE,PRM_REF,PRM_REFID,PRM_DESCR) VALUES (@name,@type,@node,@ref,@refid,@descr)'

select @prm = N'@name nvarchar(255), @type smallint, @node smallint, @ref int, @refid int, @descr nvarchar(256)'

execute sp_executesql @sql, @prm, @name, @type, @node, @ref, @refid, @descr

select @rv = ident_current(@tbl)

commit tran

return @rv

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_param_addname] TO [ap_public]
    AS [dbo];

