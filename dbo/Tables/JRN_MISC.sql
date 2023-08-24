﻿CREATE TABLE [dbo].[JRN_MISC] (
    [JM_KEY] INT IDENTITY (1, 1) NOT NULL,
    [J_ID]   INT NOT NULL,
    [MSC_ID] INT NOT NULL,
    [MSC_NO] INT NOT NULL,
    CONSTRAINT [PK_JRN_MISC] PRIMARY KEY NONCLUSTERED ([JM_KEY] ASC),
    CONSTRAINT [FK_JRN_MISC_JOURNAL] FOREIGN KEY ([J_ID]) REFERENCES [dbo].[JOURNAL] ([J_ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[JRN_MISC] NOCHECK CONSTRAINT [FK_JRN_MISC_JOURNAL];


GO
CREATE NONCLUSTERED INDEX [IX_JRN_MISC_J_ID]
    ON [dbo].[JRN_MISC]([J_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_JRN_MISC_MSC_ID]
    ON [dbo].[JRN_MISC]([MSC_ID] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_JRN_MISC_J_ID_MSC_NO]
    ON [dbo].[JRN_MISC]([J_ID] ASC, [MSC_NO] ASC);


GO
GRANT SELECT
    ON OBJECT::[dbo].[JRN_MISC] TO [ap_public]
    AS [dbo];

