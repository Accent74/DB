----------------------------------------
create procedure ap_external_copy2
@type smallint,
@id int,
@to int
as
set nocount on
begin tran

insert into EXT_DOCS
  (EXT_X,EXT_X_ID,EXT_NAME,EXT_FILE,EXT_MEMO)
select
 @type,@to,EXT_NAME,EXT_FILE,EXT_MEMO 
from EXT_DOCS where EXT_ID=@id
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_external_copy2] TO [ap_public]
    AS [dbo];

