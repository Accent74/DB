----------------------------------------
create procedure ap_form_save
@id int,
@name nvarchar(256) = null,
@file nvarchar(256) = null,
@short nvarchar(17) = null,
@memo nvarchar(256) = null,
@fa int = null,
@fld int = null,
@tag nvarchar(51) = null
as

set nocount on

begin tran

update FORMS set FRM_NAME=@name, FRM_FILE=@file, FRM_SHORT=@short, 
                 FRM_MEMO=@memo, FA_ID=@fa, FLD_ID=@fld, FRM_TAG=@tag 
where FRM_ID=@id

commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_form_save] TO [ap_public]
    AS [dbo];

