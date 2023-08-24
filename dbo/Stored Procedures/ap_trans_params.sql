----------------------------------------
create procedure ap_trans_params
@prmid int,
@jid int,
@lng int,
@str nvarchar(256),
@dbl float,
@cy money,
@dt datetime,
@null smallint
as
set nocount on
declare @present smallint
select @present = case when exists(select * from JRN_PARAMS where PRM_ID=@prmid and J_ID=@jid) then 1 else 0 end
if @present <> 0
  begin
    -- был в БД
    if @null <> 0
      begin
        -- delete param
        delete from JRN_PARAMS where PRM_ID=@prmid and J_ID=@jid
      end
    else
      begin
         -- update param
         update JRN_PARAMS set PRM_LONG=@lng, PRM_STRING=@str, 
                PRM_DOUBLE = @dbl, PRM_CY=@cy, PRM_DATE=@dt
         where PRM_ID=@prmid and J_ID = @jid
      end
  end
else 
  begin
    -- не было в БД
    if @null = 0
      begin
        -- создать
        insert into JRN_PARAMS (PRM_ID,J_ID,PRM_LONG,PRM_STRING,PRM_DOUBLE,PRM_CY,PRM_DATE)
        values (@prmid,@jid,@lng,@str,@dbl,@cy,@dt)
      end
  end


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_trans_params] TO [ap_public]
    AS [dbo];

