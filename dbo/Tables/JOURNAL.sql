﻿CREATE TABLE [dbo].[JOURNAL] (
    [J_ID]    INT          IDENTITY (1, 1) NOT NULL,
    [DOC_ID]  INT          NOT NULL,
    [J_DONE]  SMALLINT     NOT NULL,
    [J_DATE]  DATETIME     NOT NULL,
    [J_TR_NO] SMALLINT     NOT NULL,
    [J_LN_NO] SMALLINT     NOT NULL,
    [J_SUM]   MONEY        CONSTRAINT [JOURNAL_DEF_SUM] DEFAULT ((0)) NOT NULL,
    [J_QTY]   MONEY        CONSTRAINT [JOURNAL_DEF_QTY] DEFAULT ((0)) NOT NULL,
    [JF_QTY]  MONEY        CONSTRAINT [JOURNAL_DEF_FQTY] DEFAULT ((0)) NOT NULL,
    [MC_ID]   INT          NULL,
    [ACC_DB]  INT          NULL,
    [ACC_CR]  INT          NULL,
    [J_AG1]   INT          NULL,
    [J_AG2]   INT          NULL,
    [J_ENT]   INT          NULL,
    [J_UN]    INT          NULL,
    [J_PRICE] MONEY        NULL,
    [J_LINK]  INT          NULL,
    [JF_UN]   INT          NULL,
    [SER_ID]  INT          NULL,
    [PDOC_ID] INT          NULL,
    [J_AB1]   INT          NULL,
    [J_AB2]   INT          NULL,
    [J_TAG]   NVARCHAR (8) NULL,
    [CRC_ID]  INT          NULL,
    [J_CSUM]  MONEY        NULL,
    [J_CESUM] MONEY        NULL,
    CONSTRAINT [PK_JOURNAL] PRIMARY KEY NONCLUSTERED ([J_ID] ASC),
    CONSTRAINT [FK_AGENTS_JOURNAL_MC] FOREIGN KEY ([MC_ID]) REFERENCES [dbo].[AGENTS] ([AG_ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_JOURNAL_ACCOUNTS] FOREIGN KEY ([ACC_DB]) REFERENCES [dbo].[ACCOUNTS] ([ACC_ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_JOURNAL_ACCOUNTS1] FOREIGN KEY ([ACC_CR]) REFERENCES [dbo].[ACCOUNTS] ([ACC_ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_JOURNAL_AG_BANKS] FOREIGN KEY ([J_AB1]) REFERENCES [dbo].[AG_BANKS] ([AB_PK]) NOT FOR REPLICATION,
    CONSTRAINT [FK_JOURNAL_AG_BANKS_2] FOREIGN KEY ([J_AB2]) REFERENCES [dbo].[AG_BANKS] ([AB_PK]) NOT FOR REPLICATION,
    CONSTRAINT [FK_JOURNAL_AGENTS] FOREIGN KEY ([J_AG1]) REFERENCES [dbo].[AGENTS] ([AG_ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_JOURNAL_AGENTS1] FOREIGN KEY ([J_AG2]) REFERENCES [dbo].[AGENTS] ([AG_ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_JOURNAL_DOCUMENTS] FOREIGN KEY ([DOC_ID]) REFERENCES [dbo].[DOCUMENTS] ([DOC_ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_JOURNAL_DOCUMENTS_PDOCID] FOREIGN KEY ([PDOC_ID]) REFERENCES [dbo].[DOCUMENTS] ([DOC_ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_JOURNAL_ENTITIES] FOREIGN KEY ([J_ENT]) REFERENCES [dbo].[ENTITIES] ([ENT_ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_JOURNAL_SERIES] FOREIGN KEY ([SER_ID]) REFERENCES [dbo].[SERIES] ([SER_ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_JOURNAL_UNITS] FOREIGN KEY ([J_UN]) REFERENCES [dbo].[UNITS] ([UN_ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_JOURNAL_UNITS_F] FOREIGN KEY ([JF_UN]) REFERENCES [dbo].[UNITS] ([UN_ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[JOURNAL] NOCHECK CONSTRAINT [FK_JOURNAL_ACCOUNTS];


GO
ALTER TABLE [dbo].[JOURNAL] NOCHECK CONSTRAINT [FK_JOURNAL_ACCOUNTS1];


GO
ALTER TABLE [dbo].[JOURNAL] NOCHECK CONSTRAINT [FK_JOURNAL_AGENTS];


GO
ALTER TABLE [dbo].[JOURNAL] NOCHECK CONSTRAINT [FK_JOURNAL_AGENTS1];


GO
ALTER TABLE [dbo].[JOURNAL] NOCHECK CONSTRAINT [FK_JOURNAL_DOCUMENTS];


GO
ALTER TABLE [dbo].[JOURNAL] NOCHECK CONSTRAINT [FK_JOURNAL_DOCUMENTS_PDOCID];


GO
ALTER TABLE [dbo].[JOURNAL] NOCHECK CONSTRAINT [FK_JOURNAL_ENTITIES];


GO
ALTER TABLE [dbo].[JOURNAL] NOCHECK CONSTRAINT [FK_JOURNAL_SERIES];


GO
ALTER TABLE [dbo].[JOURNAL] NOCHECK CONSTRAINT [FK_JOURNAL_UNITS];


GO
ALTER TABLE [dbo].[JOURNAL] NOCHECK CONSTRAINT [FK_JOURNAL_UNITS_F];


GO
CREATE CLUSTERED INDEX [IX_JOURNAL_DATE]
    ON [dbo].[JOURNAL]([J_DATE] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_JOURNAL_GUARD]
    ON [dbo].[JOURNAL]([DOC_ID] ASC, [J_TR_NO] ASC, [J_LN_NO] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_JOURNAL_DB]
    ON [dbo].[JOURNAL]([ACC_DB] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_JOURNAL_CR]
    ON [dbo].[JOURNAL]([ACC_CR] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_JOURNAL_DOC]
    ON [dbo].[JOURNAL]([DOC_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_JOURNAL_AG1]
    ON [dbo].[JOURNAL]([J_AG1] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_JOURNAL_AG2]
    ON [dbo].[JOURNAL]([J_AG2] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_JOURNAL_ENT]
    ON [dbo].[JOURNAL]([J_ENT] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_JOURNAL_MC_ID]
    ON [dbo].[JOURNAL]([MC_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_JOURNAL_SER_ID]
    ON [dbo].[JOURNAL]([SER_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_JOURNAL_J_AB1]
    ON [dbo].[JOURNAL]([J_AB1] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_JOURNAL_J_AB2]
    ON [dbo].[JOURNAL]([J_AB2] ASC);


GO
---------------------------------------------------------------------
create trigger journal_Dtrig on dbo.JOURNAL 
for delete as

-- cascade deletes from JRN_PARAMS
delete JRN_PARAMS from deleted inner join JRN_PARAMS ON deleted.J_ID = JRN_PARAMS.J_ID
-- cascade deletes from JRN_CRC
delete JRN_CRC from deleted inner join JRN_CRC ON deleted.J_ID = JRN_CRC.J_ID
-- cascade deletes from JRN_MISC
delete JRN_MISC from deleted inner join JRN_MISC ON deleted.J_ID = JRN_MISC.J_ID


GO
GRANT SELECT
    ON OBJECT::[dbo].[JOURNAL] TO [ap_public]
    AS [dbo];

