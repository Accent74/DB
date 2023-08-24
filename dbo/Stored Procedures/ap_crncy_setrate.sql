----------------------------------------
create procedure ap_crncy_setrate
@crc int,
@rt int,
@dt datetime,
@cy money
as
set nocount on
begin tran
declare @pk int
declare @num money
select @pk = 0
select @num = 0
select @pk=PK,@num = RT_NUM from CRC_RATES 
where CRC_ID=@crc and RT_ID=@rt AND RT_DATE=@dt
if @pk <> 0
begin
  -- update
  if @cy = 0 -- delete
  begin
    delete from CRC_RATES where PK=@pk
  end
  else
  begin
    if @num <> @cy
      update CRC_RATES set RT_NUM=@cy where PK=@pk
  end
end 
else
begin
  -- insert
  if @cy <> 0 -- no zero only
    insert into CRC_RATES (CRC_ID,RT_ID,RT_DATE,RT_NUM)
    values (@crc,@rt,@dt,@cy)
end 
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_crncy_setrate] TO [ap_public]
    AS [dbo];

