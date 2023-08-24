--------------------------------------------
create procedure ap_account_load7
@id1 int, @id2 int, @id3 int, @id4 int,
@id5 int,@id6 int,@id7 int
as
set nocount on
select ACC_ID, ACC_TYPE,ACC_NAME,ACC_TAG,ACC_MEMO,ACC_CODE,ACC_T_TYPE,ACC_S_TYPE,ACC_GUID
from ACCOUNTS 
where
  ACC_ID=@id1 or ACC_ID=@id2 or ACC_ID=@id3 or
  ACC_ID=@id4 or ACC_ID=@id5 or ACC_ID=@id6 or ACC_ID=@id7


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_account_load7] TO [ap_public]
    AS [dbo];

