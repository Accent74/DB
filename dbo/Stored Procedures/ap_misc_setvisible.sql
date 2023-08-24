---------------------------------------------------------------------
create procedure ap_misc_setvisible 
@id int,
@visible bit
as
set nocount on
begin tran
declare @vis int
select @vis =MSC_VISIBLE from MISC_ATTR where MSC_NO=@id
if @visible = 0
  -- сбросить старший бит
  begin
    select @vis = @vis &  0x7FFFFFFF
  end
else
   -- установить старший бит
  begin
    select @vis = @vis |  0x80000000
  end
update MISC_ATTR set MSC_VISIBLE=@vis where MSC_NO=@id
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_misc_setvisible] TO [ap_public]
    AS [dbo];

