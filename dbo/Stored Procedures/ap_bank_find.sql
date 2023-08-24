----------------------------------------------------
create procedure ap_bank_find
@mode smallint, -- 0-mfo,1-name
@param nvarchar(256)
as
declare @id int
declare @prm nvarchar(257)
select @id = 0
if @mode = 0
  select top 1 @id = BANK_ID from BANKS where BANK_MFO=@param
else if @mode = 1
  begin
    select @prm = @param + N'%'
    select top 1 @id = BANK_ID from BANKS where BANK_NAME like @prm
  end
return @id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_bank_find] TO [ap_public]
    AS [dbo];

