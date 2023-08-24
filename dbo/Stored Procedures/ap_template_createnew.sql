﻿-----------------------------------------
create procedure ap_template_createnew 
@name nvarchar(255),
@type smallint,
@parent int,
@guid uniqueidentifier = null
as

set nocount on

begin tran

declare @id int
declare @p0 int, @p1 int, @p2 int, @p3 int, @p4 int, @p5 int, @p6 int, @sc bit

if @guid is null
begin
  insert into TEMPLATES (TML_NAME,TML_TYPE) VALUES (@name,@type)
  select @id = ident_current('TEMPLATES')
end
else
begin
  insert into TEMPLATES (TML_NAME,TML_TYPE,TML_GUID) VALUES (@name,@type,@guid)
  select @id = ident_current('TEMPLATES')
end

select P0,P1,P2,P3,P4,P5,P6,P7,SHORTCUT into #tmptmltree
from TML_TREE where ID=@parent

if 0 = (select count(*) from #tmptmltree)
   insert into #tmptmltree (P0,P1,P2,P3,P4,P5,P6,P7,SHORTCUT) values (@parent,0,0,0,0,0,0,0,0)

declare #tmpcrs cursor local fast_forward read_only for
  select P0,P1,P2,P3,P4,P5,P6,SHORTCUT from #tmptmltree

if 0 <> (select count(*) from #tmptmltree where P7 <> 0)
   begin
      rollback tran
      raiserror ('Слишком большой уровень вложенности',16,-1)
      return 0
   end   

open #tmpcrs
fetch next from #tmpcrs into @p0,@p1,@p2,@p3,@p4,@p5,@p6,@sc
while @@fetch_status = 0
  begin
     -- insert into tml_tree
     insert into TML_TREE (ID,P0,P1,P2,P3,P4,P5,P6,P7,SHORTCUT) values (@id,@parent,@p0,@p1,@p2,@p3,@p4,@p5,@p6,@sc)
     fetch next from #tmpcrs into @p0,@p1,@p2,@p3,@p4,@p5,@p6,@sc
  end
close #tmpcrs
deallocate #tmpcrs

commit 
return @id

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_template_createnew] TO [ap_public]
    AS [dbo];

