CREATE TABLE [dbo].[RECIPES] (
    [RP_ID]    INT            IDENTITY (1, 1) NOT NULL,
    [ENT_ID]   INT            NOT NULL,
    [RP_NAME]  NVARCHAR (50)  NOT NULL,
    [RP_QTY]   MONEY          NOT NULL,
    [RP_FLAGS] INT            NULL,
    [RP_TAG]   NVARCHAR (50)  NULL,
    [RP_MEMO]  NVARCHAR (255) NULL,
    [RP_DATE1] DATETIME       NULL,
    [RP_DATE2] DATETIME       NULL,
    [RP_LONG1] INT            NULL,
    [RP_LONG2] INT            NULL,
    [UN_ID]    INT            NULL,
    [RP_NO]    INT            NULL,
    CONSTRAINT [PK_RECIPES] PRIMARY KEY CLUSTERED ([RP_ID] ASC),
    CONSTRAINT [FK_RECIPES_ENTITIES] FOREIGN KEY ([ENT_ID]) REFERENCES [dbo].[ENTITIES] ([ENT_ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_RECIPES_UNITS] FOREIGN KEY ([UN_ID]) REFERENCES [dbo].[UNITS] ([UN_ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[RECIPES] NOCHECK CONSTRAINT [FK_RECIPES_ENTITIES];


GO
ALTER TABLE [dbo].[RECIPES] NOCHECK CONSTRAINT [FK_RECIPES_UNITS];


GO
CREATE NONCLUSTERED INDEX [IX_RECIPES_ENT_ID]
    ON [dbo].[RECIPES]([ENT_ID] ASC);


GO
----------------------------------------
create trigger RECIPES_Dtrig on RECIPES
for delete as

-- cascade deletes from RP_CONENTS
delete RP_CONTENTS from deleted inner join RP_CONTENTS ON deleted.RP_ID = RP_CONTENTS.RP_ID
-- cascade deletes from RCP_PARAMS
delete RCP_PARAMS from deleted inner join RCP_PARAMS on deleted.RP_ID = RCP_PARAMS.RP_ID

