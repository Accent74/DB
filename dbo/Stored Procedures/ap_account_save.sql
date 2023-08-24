--------------------------------------------
create procedure ap_account_save
@id int,
@type smallint,
@name nvarchar(256),
@tag nvarchar(51),
@memo nvarchar(256),
@code nvarchar(51),
@tt smallint,
@st smallint
as
set nocount on
begin tran
update ACCOUNTS set ACC_NAME=@name, ACC_TAG=@tag,
  ACC_MEMO=@memo, ACC_CODE=@code, ACC_TYPE=@type, ACC_T_TYPE=@tt, ACC_S_TYPE=@st 
where ACC_ID=@id
if @type = -1 -- план счетов
  begin
    -- обновить коды для всех подчиненных счетов
    update ACCOUNTS set ACC_PL_CODE=@code where ACC_PLAN=@id
  end
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_account_save] TO [ap_public]
    AS [dbo];

