----------------------------------------
create procedure dbo.ap_taxreps_update
@id int,
@name nvarchar(256),
@period int = null,
@tag nvarchar(256) = null,
@memo nvarchar(256) = null,
@file nvarchar(256) = null
as
set nocount on
declare @res int
declare @oldid int

begin tran

if @id = 0
begin
  -- новый отчет
  insert into TAX_REPS (TX_NAME,TX_PERIOD,TX_TAG, TX_MEMO, TX_FILE) 
      values (@name,@period, @tag, @memo, @file)
  select @res = ident_current('TAX_REPS')
end
else
begin 
  -- существующий отчет
  update TAX_REPS set
    TX_NAME=@name, TX_PERIOD=@period,TX_TAG=@tag,TX_MEMO=@memo, TX_FILE=@file where TX_ID=@id
  select @res = @id
end
commit tran
return @res

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_taxreps_update] TO [ap_public]
    AS [dbo];

