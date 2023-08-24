----------------------------------------
create procedure ap_asset_save
@id int,
@indate datetime = null,
@inact nvarchar(255) = null,
@inactdate datetime = null,
@manuf nvarchar(255) = null,
@manufdate datetime = null,
@passp nvarchar(255) = null,
@regno nvarchar(255) = null,
@depcode nvarchar(255) = null,
@depercent money = null,
@outdate datetime = null,
@outact nvarchar(255) = null,
@outactdate datetime = null,
@life money = null,
@reason nvarchar(255) = null
as

if exists(select * from ENT_ASSETS where ENT_ID=@id)
-- update
update ENT_ASSETS set AST_IN_DATE=@indate, AST_IN_ACT_NO=@inact, AST_IN_ACT_DATE=@inactdate,
AST_MANUFACT=@manuf, AST_MANUF_DATE=@manufdate,AST_PASSPORT=@passp, AST_REG_NO=@regno,
AST_DEPREC_CODE=@depcode,AST_DEPREC_PERCENT=@depercent,AST_OUT_DATE=@outdate,
AST_OUT_ACT_NO=@outact,AST_OUT_ACT_DATE=@outactdate,AST_USEFUL_LIFE=@life,
AST_OUT_REASON=@reason
where ENT_ID=@id
else
-- insert
insert into ENT_ASSETS
(ENT_ID,AST_ENABLED,AST_IN_DATE, AST_IN_ACT_NO,AST_IN_ACT_DATE,AST_MANUFACT,AST_MANUF_DATE,
AST_PASSPORT,AST_REG_NO,AST_DEPREC_CODE,AST_DEPREC_PERCENT,AST_OUT_DATE,AST_OUT_ACT_NO,
AST_OUT_ACT_DATE,AST_USEFUL_LIFE,AST_OUT_REASON)
values
(@id,1,@indate,@inact,@inactdate,@manuf,@manufdate,@passp,@regno,@depcode,@depercent,
 @outdate,@outact,@outactdate,@life,@reason)


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_asset_save] TO [ap_public]
    AS [dbo];

