-----------------------------------------
create procedure ap_account_createnew 
@code nvarchar(51),
@name nvarchar(256),
@type smallint,
@parent int,
@guid uniqueidentifier = null
as

set nocount on

begin tran

declare @id int
declare @p0 int, @p1 int, @p2 int, @p3 int, @p4 int, @p5 int, @p6 int, @sc bit

declare @plid int
declare @plcode nvarchar(51)

select @plid = 0
select @plid = ACC_PLAN, @plcode = ACC_PL_CODE from ACCOUNTS where ACC_ID=@parent

if @plid = 0  
  begin
      rollback tran
      raiserror ('Ошибка при вставке счета',16,-1)
      return
  end

if @guid is null
begin
  insert into ACCOUNTS (ACC_NAME,ACC_TYPE,ACC_CODE,ACC_PLAN,ACC_PL_CODE,ACC_S_TYPE,ACC_T_TYPE) 
     values (@name,@type,@code,@plid,@plcode,0,0)
  select @id = ident_current('ACCOUNTS')
end
else
begin
  insert into ACCOUNTS (ACC_NAME,ACC_TYPE,ACC_CODE,ACC_PLAN,ACC_PL_CODE,ACC_S_TYPE,ACC_T_TYPE,ACC_GUID) 
     values (@name,@type,@code,@plid,@plcode,0,0,@guid)
  select @id = ident_current('ACCOUNTS')
end

select P0,P1,P2,P3,P4,P5,P6,P7,SHORTCUT into #tmpagtree
from ACC_TREE where ID=@parent

if 0 = (select count(*) from #tmpagtree)
   insert into #tmpagtree (P0,P1,P2,P3,P4,P5,P6,P7,SHORTCUT) values (@parent,0,0,0,0,0,0,0,0)

declare #tmpcrs cursor local fast_forward read_only for
  select P0,P1,P2,P3,P4,P5,P6,SHORTCUT from #tmpagtree

if 0 <> (select count(*) from #tmpagtree where P7 <> 0)
   begin
      rollback tran
      raiserror ('Слишком большой уровень вложенности',16,-1)
      return
   end   

open #tmpcrs
fetch next from #tmpcrs into @p0,@p1,@p2,@p3,@p4,@p5,@p6,@sc
while @@fetch_status = 0
  begin
     -- insert into ag_tree
     insert into ACC_TREE (ID,P0,P1,P2,P3,P4,P5,P6,P7,SHORTCUT) values (@id,@parent,@p0,@p1,@p2,@p3,@p4,@p5,@p6,@sc)
     fetch next from #tmpcrs into @p0,@p1,@p2,@p3,@p4,@p5,@p6,@sc
  end
close #tmpcrs
deallocate #tmpcrs

commit tran

select @id, @plid, @plcode

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_account_createnew] TO [ap_public]
    AS [dbo];

