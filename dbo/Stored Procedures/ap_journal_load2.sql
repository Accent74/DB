----------------------------------------
create procedure ap_journal_load2
@et Int,
@id Int,
@sd datetime,
@ed datetime,
@mcid int
as
Set nocount On
if @et = 0 And @id = 0 -- корень дерева документов
  exec ap_jrnload2_fldroot @sd, @ed, @mcid
else if @et = 0 -- папка
  exec ap_jrnload2_folder @id, @sd, @ed, @mcid
else if @et = 1 -- счет
  begin
    if @id = 0
      select null, null, null, null where 1<>1
    else
      exec ap_jrnload2_account @id, @sd, @ed, @mcid
  end
else If @et = 2 -- корреспондент
  exec ap_jrnload2_agent @id, @sd, @ed, @mcid
else If @et = 3 -- объект учета
  exec ap_jrnload2_entity @id, @sd, @ed, @mcid
else If @et = 4 -- разное
  exec ap_jrnload2_misc @id, @sd, @ed, @mcid
else If @et = 5 -- подшивка
  exec ap_jrnload2_binder @id, @sd, @ed, @mcid
else If @et = 6 -- шаблон
  exec ap_jrnload2_template @id, @sd, @ed, @mcid
else If @et = 30 -- без шаблона
 exec ap_jrnload2_untrans @sd, @ed, @mcid
else If @et = 31 -- незавершенные
  exec ap_jrnload2_undone @sd, @ed, @mcid
else If @et = 32 -- все
  exec ap_jrnload2_all @sd, @ed, @mcid
else If @et = 34 -- удаленные
  exec ap_jrnload2_trash @sd, @ed, @mcid
else If @et = 39 -- favorites
  exec ap_jrnload2_favorites @id, @sd, @ed, @mcid

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_journal_load2] TO [ap_public]
    AS [dbo];

