-----------------------------------------
create procedure ap_bank_update
@id int,
@mfo nvarchar(33),
@name nvarchar(51),
@memo nvarchar(256) = null,
@city nvarchar(129) = null,
@country nvarchar(51) = null,
@acc nvarchar(51) = null,
@corrid int = null,
@guid uniqueidentifier = null
as
set nocount on
declare @res int
declare @oldid int

begin tran

if @mfo is null or @mfo = N''
  begin
    rollback tran
    raiserror(N'Код МФО (БИК) банка не может быть пустым',16,-1)
    return 0
  end
if @id = 0
begin
  -- новый банк
  if exists(select * from BANKS where BANK_MFO=@mfo)
    begin
      rollback tran
      raiserror(N'Банк с таким кодом МФО (БИК) уже существует',16,-1)
      return 0
    end
  if @guid is null
  begin
    insert into BANKS (BANK_MFO,BANK_NAME,BANK_MEMO,BANK_CITY,BANK_COUNTRY,BANK_CORRACC,BANK_CORRID) 
      values (@mfo, @name,@memo,@city,@country,@acc,@corrid)
    select @res = ident_current('BANKS')
  end
  else
  begin
    insert into BANKS (BANK_MFO,BANK_NAME,BANK_MEMO,BANK_CITY,BANK_COUNTRY,BANK_CORRACC,BANK_CORRID,BANK_GUID) 
      values (@mfo, @name,@memo,@city,@country,@acc,@corrid,@guid)
    select @res = ident_current('BANKS')
  end
end
else
begin 
  -- существующий банк
  select @oldid = BANK_ID from BANKS where BANK_MFO=@mfo
  if @oldid <> @id 
    begin
      rollback tran
      raiserror(N'Банк с таким кодом МФО (БИК) уже существует',16,-1)
      return 0    
    end 
  update BANKS set
    BANK_MFO=@mfo,BANK_NAME=@name, BANK_MEMO=@memo,BANK_CITY=@city,
    BANK_COUNTRY=@country, BANK_CORRACC=@acc, BANK_CORRID=@corrid
  where BANK_ID=@id
  select @res = @id
end
commit tran
return @res

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_bank_update] TO [ap_public]
    AS [dbo];

