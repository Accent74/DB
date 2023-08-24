----------------------------------------
create procedure ap_crncy_update
@id int,
@code nvarchar(33),
@short nvarchar(256),
@name nvarchar(256),
@spell nvarchar(256),
@denom int,
@flags int = null,
@fmt int = null
as
set nocount on
declare @resid int
begin tran
if @id = 0
  begin
    -- insert
    if @code <> N'' and 0 < (select count(*) from CURRENCIES where CRC_CODE=@code)
      begin
        -- 
        rollback tran
        raiserror(N'Валюта с таким кодом уже существует',16,-1)
        return 0
      end
    insert into CURRENCIES (CRC_CODE,CRC_SHORT,CRC_NAME,CRC_SPELL,CRC_DENOM,CRC_FLAGS,CRC_FORMAT) 
      values (@code,@short,@name,@spell,@denom,@flags,@fmt)
    select @resid = ident_current('CURRENCIES')
  end 
else
  begin
    -- update
    declare @oldcode nvarchar(256)
    select @oldcode = CRC_CODE from CURRENCIES where CRC_ID=@id
    if @oldcode <> @code 
      begin
        -- попытка изменить код валюты
        if @code <> N'' and 0 < (select count(*) from CURRENCIES where CRC_CODE=@code)
          begin
            rollback tran
            raiserror(N'Валюта с таким кодом уже существует',16,-1)
            return 0
          end
      end
    update CURRENCIES set CRC_CODE=@code, CRC_NAME=@name, CRC_SHORT=@short,
        CRC_SPELL=@spell, CRC_DENOM=@denom, CRC_FLAGS=@flags, CRC_FORMAT=@fmt
	where CRC_ID = @id
    select @resid = @id
  end
commit tran
return @resid

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_crncy_update] TO [ap_public]
    AS [dbo];

