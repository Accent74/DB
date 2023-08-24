﻿CREATE TABLE [dbo].[EXT_DOCS] (
    [EXT_ID]   INT              IDENTITY (1, 1) NOT NULL,
    [EXT_GUID] UNIQUEIDENTIFIER CONSTRAINT [DF_EXT_DOCS_EXT_GUID] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [EXT_X]    SMALLINT         NOT NULL,
    [EXT_X_ID] INT              NOT NULL,
    [EXT_NAME] NVARCHAR (255)   NULL,
    [EXT_FILE] NVARCHAR (255)   NULL,
    [EXT_MEMO] NVARCHAR (255)   NULL,
    CONSTRAINT [PK_EXT_DOCS] PRIMARY KEY NONCLUSTERED ([EXT_ID] ASC)
);
