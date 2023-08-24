﻿CREATE TABLE [dbo].[RP_CONTENTS] (
    [RC_ID]      INT           IDENTITY (1, 1) NOT NULL,
    [RP_ID]      INT           NOT NULL,
    [ENT_ID]     INT           NOT NULL,
    [RC_QTY]     MONEY         NOT NULL,
    [RC_NO]      INT           NULL,
    [RC_CY1]     MONEY         NULL,
    [RC_CY2]     MONEY         NULL,
    [RC_TAG]     NVARCHAR (50) NULL,
    [RC_PERCENT] MONEY         NULL,
    [AG_ID]      INT           NULL,
    [UN_ID]      INT           NULL,
    CONSTRAINT [PK_RP_CONTENTS] PRIMARY KEY CLUSTERED ([RC_ID] ASC),
    CONSTRAINT [FK_RP_CONTENTS_AGENTS] FOREIGN KEY ([AG_ID]) REFERENCES [dbo].[AGENTS] ([AG_ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_RP_CONTENTS_ENTITIES] FOREIGN KEY ([ENT_ID]) REFERENCES [dbo].[ENTITIES] ([ENT_ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_RP_CONTENTS_RECIPES] FOREIGN KEY ([RP_ID]) REFERENCES [dbo].[RECIPES] ([RP_ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_RP_CONTENTS_UNITS] FOREIGN KEY ([UN_ID]) REFERENCES [dbo].[UNITS] ([UN_ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[RP_CONTENTS] NOCHECK CONSTRAINT [FK_RP_CONTENTS_AGENTS];


GO
ALTER TABLE [dbo].[RP_CONTENTS] NOCHECK CONSTRAINT [FK_RP_CONTENTS_ENTITIES];


GO
ALTER TABLE [dbo].[RP_CONTENTS] NOCHECK CONSTRAINT [FK_RP_CONTENTS_RECIPES];


GO
ALTER TABLE [dbo].[RP_CONTENTS] NOCHECK CONSTRAINT [FK_RP_CONTENTS_UNITS];


GO
CREATE NONCLUSTERED INDEX [IX_RP_CONTENTS_RP_ID]
    ON [dbo].[RP_CONTENTS]([RP_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_RP_CONTENTS_ENT_ID]
    ON [dbo].[RP_CONTENTS]([ENT_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_RP_CONTENTS_AG_ID]
    ON [dbo].[RP_CONTENTS]([AG_ID] ASC);


GO
----------------------------------------
create trigger RP_CONTENTS_Dtrig on RP_CONTENTS
for delete as

-- cascade deletes from RPE_PARAMS
delete RPE_PARAMS from deleted inner join RPE_PARAMS on deleted.RC_ID = RPE_PARAMS.RC_ID

