---------------------------------------------------------------------
create procedure ap_folder_save
@id int,
@name nvarchar(256),
@tag nvarchar(256),
@memo nvarchar(256),
@tml int = 0,
@frm int = 0
as
set nocount on
begin transaction
if @tml = 0
  select @tml = null
if @frm = 0
  select @frm = null
update FOLDERS set FLD_NAME=@name, FLD_TAG=@tag, FLD_MEMO=@memo, TML_ID=@tml, FRM_ID=@frm
where FLD_ID=@id
commit transaction


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_folder_save] TO [ap_public]
    AS [dbo];

