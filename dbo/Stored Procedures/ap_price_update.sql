-----------------------------------------
create procedure ap_price_update
@pk int,
@cy money,
@dt datetime,
@ent int,
@prc int,
@prl int
as
set nocount on
declare @res int
select @res = @pk
begin tran
if @pk <> 0 and @cy = 0
  begin
    -- удалить цену
    delete from PRC_CONTENTS where PK=@pk
    select @res = 0 
  end
else if @pk = 0
  begin
    -- добавить новую цену и вернуть PK
    insert into PRC_CONTENTS (PRC_DATE,ENT_ID,PRC_ID,PRC_VALUE,PRL_ID)
       values (@dt,@ent,@prc,@cy,@prl)
    select @res = ident_current('PRC_CONTENTS')
  end
else
  begin 
    -- обновить цену
    update PRC_CONTENTS set PRC_VALUE=@cy where PK=@pk
  end
  
commit tran
return @res

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_price_update] TO [ap_public]
    AS [dbo];

