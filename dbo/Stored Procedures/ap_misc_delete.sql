-------------------------------------------
create procedure ap_misc_delete
@id int
as
set nocount on
begin tran

declare @type int
declare @no int

select @type = MSC_TYPE, @no=MSC_NO from MISC where MSC_ID=@id

delete from MISC where MSC_ID=@id
exec ap_log_add N'M',N'D',@id

if @type = -1
  begin
   delete from MISC_PARAM_NAMES where NODE_TYPE=@no
   delete from MISC_FACT_NAMES where NODE_TYPE=@no
    -- удалим запись из MISC_ATTR
   delete from MISC_ATTR where MSC_NO=@no
  end
commit


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_misc_delete] TO [ap_public]
    AS [dbo];

