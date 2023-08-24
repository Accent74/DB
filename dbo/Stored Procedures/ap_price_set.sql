----------------------------------------
create procedure ap_price_set
@ent int,
@prc int,
@dat datetime,
@value money,
@prl int
as
set nocount on
begin tran
declare @pk int
select @pk = 0
select @pk = PK from PRC_CONTENTS 
where ENT_ID=@ent and PRC_ID=@prc and PRC_DATE=@dat and PRL_ID=@prl

if @pk is null
select @pk = 0

if @pk = 0
begin
-- insert
if @value <> 0
  insert into PRC_CONTENTS (ENT_ID,PRC_ID,PRC_DATE,PRC_VALUE,PRL_ID)
  values (@ent,@prc,@dat,@value,@prl)
end
else 
begin
-- update
if @value <> 0
 update PRC_CONTENTS set PRC_VALUE=@value where PK=@pk
else
 delete from PRC_CONTENTS where PK=@pk
end
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_price_set] TO [ap_public]
    AS [dbo];

