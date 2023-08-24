CREATE TABLE [dbo].[ENTITIES] (
    [ENT_ID]   INT              IDENTITY (1, 1) NOT NULL,
    [ENT_GUID] UNIQUEIDENTIFIER CONSTRAINT [DF_ENTITIES_ENT_GUID] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [ENT_TYPE] SMALLINT         NOT NULL,
    [ENT_NAME] NVARCHAR (255)   NOT NULL,
    [ENT_CODE] NVARCHAR (50)    NULL,
    [ENT_TAG]  NVARCHAR (50)    NULL,
    [ENT_CAT]  NVARCHAR (50)    NULL,
    [ENT_NOM]  NVARCHAR (50)    NULL,
    [ENT_ART]  NVARCHAR (50)    NULL,
    [ENT_BAR]  NVARCHAR (50)    NULL,
    [ENT_MEMO] NVARCHAR (255)   NULL,
    [UN_ID]    INT              NULL,
    [UN_SELF]  INT              NULL,
    [ACC_ID]   INT              NULL,
    [ACC_SELF] SMALLINT         NULL,
    CONSTRAINT [PK_ENTITIES] PRIMARY KEY NONCLUSTERED ([ENT_ID] ASC),
    CONSTRAINT [FK_ENTITIES_ACCOUNTS] FOREIGN KEY ([ACC_ID]) REFERENCES [dbo].[ACCOUNTS] ([ACC_ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ENTITIES_UNITS] FOREIGN KEY ([UN_ID]) REFERENCES [dbo].[UNITS] ([UN_ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[ENTITIES] NOCHECK CONSTRAINT [FK_ENTITIES_ACCOUNTS];


GO
ALTER TABLE [dbo].[ENTITIES] NOCHECK CONSTRAINT [FK_ENTITIES_UNITS];


GO
--------------------------------------
create trigger entities_Dtrig on dbo.ENTITIES
for delete as
-- check journal
if exists (select * from JOURNAL inner join deleted on JOURNAL.J_ENT=deleted.ENT_ID) 
begin
   raiserror ('Объект учета удалить нельзя, он используется в журнале операций', 16, 1)
   rollback transaction
end
if exists (select * from ENT_TREE inner join deleted on ENT_TREE.P0=deleted.ENT_ID)
begin
   raiserror ('Объект учета удалить нельзя, в нем есть вложенные', 16, 1)
   rollback transaction
end
-- cascade deletes from ENT_TREE 
delete ENT_TREE from deleted inner join ENT_TREE ON deleted.ENT_ID = ENT_TREE.ID
-- cascade deletes from ENT_PARAMS
delete ENT_PARAMS from deleted inner join ENT_PARAMS ON deleted.ENT_ID = ENT_PARAMS.ENT_ID
-- cascade deletes from ENT_ASSETS
delete ENT_ASSETS from deleted inner join ENT_ASSETS ON deleted.ENT_ID = ENT_ASSETS.ENT_ID
-- delete dependent records from REPORTS
delete from REPORTS where  REP_X=2 and REP_X_ID in (select ENT_ID from deleted)
-- delete dependent records from EXT_DOCS
delete from EXT_DOCS where EXT_X=3 and EXT_X_ID in (select ENT_ID from deleted)
-- delete dependent records from PRC_CONTENTS
delete PRC_CONTENTS from deleted inner join PRC_CONTENTS ON deleted.ENT_ID = PRC_CONTENTS.ENT_ID
-- delete dependent records from ENT_UNITS
delete ENT_UNITS from deleted inner join ENT_UNITS ON deleted.ENT_ID = ENT_UNITS.ENT_ID
-- cascade deletes from ENT_FACTS
delete ENT_FACTS from deleted inner join ENT_FACTS ON deleted.ENT_ID = ENT_FACTS.EL_ID
-- cascade deletes from RP_CONTENTS
delete RP_CONTENTS from deleted inner join RP_CONTENTS ON deleted.ENT_ID = RP_CONTENTS.ENT_ID
-- cascade deletes from RECIPES
delete RECIPES from deleted inner join RECIPES ON deleted.ENT_ID = RECIPES.ENT_ID
-- cascade deletes from SERIES
delete SERIES from deleted inner join SERIES ON deleted.ENT_ID = SERIES.ENT_ID
-- delete dependent records from ACL
delete from ACL where KIND=3 and EL_ID in (select ENT_ID from deleted)

GO
GRANT SELECT
    ON OBJECT::[dbo].[ENTITIES] TO [ap_public]
    AS [dbo];

