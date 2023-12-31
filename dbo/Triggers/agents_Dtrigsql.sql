USE [Accent7]
GO
/****** Object:  Trigger [dbo].[agents_Dtrig]    Script Date: 24.08.2023 12:44:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-----------------------------------------
ALTER trigger [dbo].[agents_Dtrig] on [dbo].[AGENTS] 
for delete as
-- check journal
if exists (select * from JOURNAL inner join deleted on JOURNAL.J_AG1=deleted.AG_ID or JOURNAL.J_AG2=deleted.AG_ID) 
begin
   raiserror (' орреспондента удалить нельз¤, он используетс¤ в журнале операций', 16, 1)
   rollback transaction
end
if exists (select * from AG_TREE inner join deleted on AG_TREE.P0=deleted.AG_ID)
begin
   raiserror (' орреспондента удалить нельз¤, в нем есть вложенные', 16, 1)
   rollback transaction
end
-- cascade deletes from AG_TREE 
delete AG_TREE from deleted inner join AG_TREE ON deleted.AG_ID = AG_TREE.ID
-- cascade deletes from AG_PARAMS
delete AG_PARAMS from deleted inner join AG_PARAMS ON deleted.AG_ID = AG_PARAMS.AG_ID
-- cascade deletes from AG_BANKS
delete AG_BANKS from deleted inner join AG_BANKS ON deleted.AG_ID = AG_BANKS.AG_ID
-- delete dependent records from REPORTS
delete from REPORTS where  REP_X=1 and REP_X_ID in (select AG_ID from deleted)
-- delete dependent records from EXT_DOCS
delete from EXT_DOCS where EXT_X=2 and EXT_X_ID in (select AG_ID from deleted)
-- cascade deletes from AG_FACTS
delete AG_FACTS from deleted inner join AG_FACTS ON deleted.AG_ID = AG_FACTS.EL_ID
-- delete dependent records from ACL
delete from ACL where KIND=2 and EL_ID in (select AG_ID from deleted)
-- update RP_CONTENTS with this AGENT
update RP_CONTENTS set RP_CONTENTS.AG_ID=null where RP_CONTENTS.AG_ID in (select deleted.AG_ID from deleted)
