----------------------------------------
create procedure ap_fact_addname
@et int,
@name nvarchar(256),
@type smallint,
@node int,
@ref int = null,
@refid int = null,
@descr nvarchar(256) = null
as
set nocount on

declare @tnames nvarchar(32)
declare @tvals  nvarchar(32)
declare @sql nvarchar(255)
declare @rv int
declare @prm nvarchar(255)
 
exec apx_et_facts @et, @tnames OUT, @tvals OUT
select @sql = N'INSERT INTO ' + @tnames + 
	      N' (FA_NAME,FA_TYPE,NODE_TYPE,FA_REF,FA_REFID, FA_DESCR) VALUES (@name,@type,@node,@ref,@refid, @descr)'

select @prm = N'@name nvarchar(255), @type smallint, @node int, @ref int, @refid int, @descr nvarchar(255)'
execute sp_executesql @sql, @prm, @name, @type, @node, @ref, @refid, @descr

select @rv = ident_current(@tnames)

return @rv


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_fact_addname] TO [ap_public]
    AS [dbo];

