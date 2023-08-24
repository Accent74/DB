-----------------------------------------
create procedure ap_misc_createnew 
@no int, -- номер аналитики
@name nvarchar(255),
@type smallint,
@parent int,
@guid uniqueidentifier = null
as

set nocount on

begin tran

declare @id int
declare @p0 int, @p1 int, @p2 int, @p3 int, @p4 int, @p5 int, @p6 int, @sc bit

if @type = -1
  begin
     -- добавим запись в MISC_ATTR    
    insert into MISC_ATTR (MSC_VISIBLE) values (0)
    select @no = ident_current('MISC_ATTR')
  end

if @guid is null
begin
  insert into MISC (MSC_NO,MSC_NAME,MSC_TYPE) VALUES (@no, @name,@type)
  select @id = ident_current('MISC')
end
else
begin
  insert into MISC (MSC_NO,MSC_NAME,MSC_TYPE,MSC_GUID) VALUES (@no, @name,@type,@guid)
  select @id = ident_current('MISC')
end

select P0,P1,P2,P3,P4,P5,P6,P7,SHORTCUT into #tmpmsctree
from MISC_TREE where ID=@parent

if 0 = (select count(*) from #tmpmsctree)
   insert into #tmpmsctree (P0,P1,P2,P3,P4,P5,P6,P7,SHORTCUT) values (@parent,0,0,0,0,0,0,0,0)

declare #tmpcrs cursor local fast_forward read_only for
  select P0,P1,P2,P3,P4,P5,P6,SHORTCUT from #tmpmsctree

if exists(select * from #tmpmsctree where P7 <> 0)
   begin
      rollback tran
      raiserror ('Слишком большой уровень вложенности',16,-1)
      return 0
   end   

open #tmpcrs
fetch next from #tmpcrs into @p0,@p1,@p2,@p3,@p4,@p5,@p6,@sc
while @@fetch_status = 0
  begin
     -- insert into msc_tree
     insert into MISC_TREE (ID,P0,P1,P2,P3,P4,P5,P6,P7,SHORTCUT) values (@id,@parent,@p0,@p1,@p2,@p3,@p4,@p5,@p6,@sc)
     fetch next from #tmpcrs into @p0,@p1,@p2,@p3,@p4,@p5,@p6,@sc
  end
close #tmpcrs
deallocate #tmpcrs

commit 
return @id

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_misc_createnew] TO [ap_public]
    AS [dbo];

