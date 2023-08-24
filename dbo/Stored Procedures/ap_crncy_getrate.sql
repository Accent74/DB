----------------------------------------
create procedure ap_crncy_getrate
@crc int,
@rt int,
@dt datetime
as
set nocount on
declare @num money
select @num = 0.0
select @num = RT_NUM FROM CRC_RATES
where CRC_ID=@crc and RT_ID=@rt and RT_DATE = 
(select max(X.RT_DATE) from CRC_RATES as X 
 where X.RT_DATE<=@dt and X.CRC_ID=@crc and X.RT_ID=@rt)
select @num


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_crncy_getrate] TO [ap_public]
    AS [dbo];

