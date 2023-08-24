-----------------------------------------
create procedure ap_series_update
@id int,
@ent int,
@name nvarchar(255),
@tag nvarchar(255) = null,
@memo nvarchar(255) = null,
@num nvarchar(51) = null,
@code nvarchar(51) = null,
@date1 datetime = null,
@date2 datetime = null,
@cy1 money = null,
@cy2 money = null,
@lng1 int = null
as
set nocount on
begin tran
declare @ret int
select @ret = 0
if @id = 0
begin
  insert into SERIES (ENT_ID,SER_NAME,SER_TAG,SER_MEMO,SER_CODE,SER_NUMBER,
                      SER_DATE1,SER_DATE2,SER_CY1,SER_CY2,SER_LONG1)
  values(@ent, @name,@tag,@memo,@code,@num,@date1,@date2,@cy1,@cy2,@lng1)
  select @ret = ident_current('SERIES')
end
else
begin
  update SERIES set 
    SER_NAME=@name, SER_TAG=@tag, SER_MEMO=@memo, SER_CODE=@code, SER_NUMBER=@num,
    SER_DATE1=@date1, SER_DATE2=@date2, SER_CY1=@cy1, SER_CY2=@cy2, SER_LONG1=@lng1
    where SER_ID=@id
  select @ret = @id
end
commit tran
return @ret

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_series_update] TO [ap_public]
    AS [dbo];

