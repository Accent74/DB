﻿CREATE TABLE [dbo].[MISC_FACTS] (
    [EL_ID]     INT            NOT NULL,
    [FA_ID]     INT            NOT NULL,
    [FA_FDATE]  DATETIME       NOT NULL,
    [FA_LONG]   INT            NULL,
    [FA_STRING] NVARCHAR (255) NULL,
    [FA_DOUBLE] FLOAT (53)     NULL,
    [FA_DATE]   DATETIME       NULL,
    [FA_CY]     MONEY          NULL,
    CONSTRAINT [PK_MISC_FACTS] PRIMARY KEY CLUSTERED ([EL_ID] ASC, [FA_ID] ASC, [FA_FDATE] ASC),
    CONSTRAINT [FK_MISC_FACT_NAMES_FACTS] FOREIGN KEY ([FA_ID]) REFERENCES [dbo].[MISC_FACT_NAMES] ([FA_ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_MISC_FACTS3] FOREIGN KEY ([EL_ID]) REFERENCES [dbo].[MISC] ([MSC_ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[MISC_FACTS] NOCHECK CONSTRAINT [FK_MISC_FACT_NAMES_FACTS];


GO
ALTER TABLE [dbo].[MISC_FACTS] NOCHECK CONSTRAINT [FK_MISC_FACTS3];


GO
GRANT DELETE
    ON OBJECT::[dbo].[MISC_FACTS] TO [ap_public]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[MISC_FACTS] TO [ap_public]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[MISC_FACTS] TO [ap_public]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[MISC_FACTS] TO [ap_public]
    AS [dbo];

