----------------------------------------
create procedure ap_agent_save
@id int,
@name nvarchar(256),
@tag nvarchar(51),
@memo nvarchar(256),
@code nvarchar(51) = null,
@addr nvarchar(256) = null,
@phone nvarchar(51) = null,
@vat nvarchar(51) = null,
@reg nvarchar(51) = null,
@tab nvarchar(51) = null,
@pasp nvarchar(256) = null,
@date1 datetime = null,
@date2 datetime = null,
@cnt nvarchar(256) = null,
@country nvarchar(51) = null,
@email nvarchar(256) = null,
@www nvarchar(256) = null
as
set nocount on
begin transaction
update AGENTS set 
  AG_NAME=@name, AG_TAG=@tag, AG_MEMO=@memo, AG_CODE=@code, AG_ADDRESS=@addr,
  AG_PHONE=@phone, AG_VATNO=@vat, AG_REGNO=@reg, AG_TABNO=@tab, AG_PASSPORT=@pasp,
  AG_DATE1=@date1, AG_DATE2=@date2, AG_CONTACT=@cnt, AG_COUNTRY=@country,
  AG_EMAIL=@email, AG_WWW=@www
where AG_ID=@id
commit transaction


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_agent_save] TO [ap_public]
    AS [dbo];

