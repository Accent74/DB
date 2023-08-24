----------------------------------------
create procedure ap_doclist_load2
@et smallint,
@id int,
@sd datetime,
@ed datetime,
@showtrans bit = 0,
@unlink bit = 0,
@frm int = null,
@mcid int = null
as

set nocount on

if @et = 0 -- folder
begin
  if @id = 0 -- root
    exec ap_docload2_fldroot @sd, @ed, @mcid
  else -- normal folder
    exec ap_docload2_folder @id, @sd, @ed, @mcid
end
else if @et = 1 -- account
  exec ap_docload2_account @id, @sd, @ed, @mcid
else if @et = 2 -- agent
  exec ap_docload2_agent @id, @sd, @ed, @mcid
else if @et = 3 -- entity
  exec ap_docload2_entity @id, @sd, @ed, @mcid
else if @et = 4 -- misc
  exec ap_docload2_misc @id, @sd, @ed, @mcid
else if @et = 5 -- binder
  exec ap_docload2_binder @id, @sd, @ed, @mcid
else if @et = 6 -- template
  exec ap_docload2_template @id, @sd, @ed, @mcid
else if @et = 14 -- form
  exec ap_docload2_form @id, @sd, @ed, @mcid
else if @et = 15 -- links
  exec ap_docload2_link @id, @mcid
else if @et = 30 -- untemplate
  exec ap_docload2_untemplate @sd, @ed, @mcid
else if @et = 31 -- uncomplete
  exec ap_docload2_uncomplete @sd, @ed, @mcid
else if @et = 32 -- all docs
  exec ap_docload2_all @sd, @ed, @mcid
else if @et = 34 -- trash
  exec ap_docload2_trash @sd, @ed, @mcid
else if @et = 39 -- favorites
  exec ap_docload2_favorites @id, @sd, @ed, @mcid

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_doclist_load2] TO [ap_public]
    AS [dbo];

