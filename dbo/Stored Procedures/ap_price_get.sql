-----------------------------------------
create procedure ap_price_get
@ent int,
@prc int,
@dat datetime,
@prl int
as
set nocount on
declare @ret money 
declare @adat datetime
select @ret = 0
select @ret = PRC_VALUE, @adat=PRC_DATE from PRC_CONTENTS 
where ENT_ID=@ent and PRC_ID =@prc and PRL_ID=@prl and 
 PRC_DATE = (select max(X.PRC_DATE) from PRC_CONTENTS as X 
             where X.PRC_ID=@prc and X.ENT_ID=@ent and X.PRL_ID=@prl and X.PRC_DATE<=@dat)
select @ret, @adat

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_price_get] TO [ap_public]
    AS [dbo];

