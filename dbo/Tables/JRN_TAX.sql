﻿CREATE TABLE [dbo].[JRN_TAX] (
    [JT_KEY]   INT           IDENTITY (1, 1) NOT NULL,
    [J_ID]     INT           NOT NULL,
    [TX_ID]    INT           NOT NULL,
    [JT_ADDR1] NVARCHAR (50) NULL,
    [JT_ADDR2] NVARCHAR (50) NULL,
    [JT_SIGN]  INT           NULL,
    CONSTRAINT [FK_JRN_TAX_JOURNAL2] FOREIGN KEY ([J_ID]) REFERENCES [dbo].[JOURNAL] ([J_ID]) ON DELETE CASCADE NOT FOR REPLICATION,
    CONSTRAINT [FK_JRN_TAX_TAX_REPS2] FOREIGN KEY ([TX_ID]) REFERENCES [dbo].[TAX_REPS] ([TX_ID]) NOT FOR REPLICATION,
    CONSTRAINT [IX_JRN_TAX_J_ID_TX_ID] UNIQUE NONCLUSTERED ([J_ID] ASC, [TX_ID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_JRN_TAX_J_ID]
    ON [dbo].[JRN_TAX]([J_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_JRN_TAX_TX_ID]
    ON [dbo].[JRN_TAX]([TX_ID] ASC);

