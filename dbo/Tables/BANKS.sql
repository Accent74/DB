﻿CREATE TABLE [dbo].[BANKS] (
    [BANK_ID]      INT              IDENTITY (1, 1) NOT NULL,
    [BANK_GUID]    UNIQUEIDENTIFIER CONSTRAINT [DF_BANKS_BANK_GUID] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [BANK_MFO]     NVARCHAR (32)    NOT NULL,
    [BANK_NAME]    NVARCHAR (50)    NOT NULL,
    [BANK_CITY]    NVARCHAR (128)   NULL,
    [BANK_COUNTRY] NVARCHAR (50)    NULL,
    [BANK_MEMO]    NVARCHAR (255)   NULL,
    [BANK_CORRACC] NVARCHAR (50)    NULL,
    [BANK_CORRID]  INT              NULL,
    CONSTRAINT [PK_BANKS] PRIMARY KEY NONCLUSTERED ([BANK_ID] ASC),
    CONSTRAINT [FK_BANKS_BANKS] FOREIGN KEY ([BANK_CORRID]) REFERENCES [dbo].[BANKS] ([BANK_ID]) NOT FOR REPLICATION,
    CONSTRAINT [IX_BANKS_GUID] UNIQUE NONCLUSTERED ([BANK_GUID] ASC)
);


GO
ALTER TABLE [dbo].[BANKS] NOCHECK CONSTRAINT [FK_BANKS_BANKS];

