﻿CREATE TABLE [dbo].[TAX_REPS] (
    [TX_ID]     INT            IDENTITY (1, 1) NOT NULL,
    [TX_NAME]   NVARCHAR (255) NOT NULL,
    [TX_PERIOD] INT            NULL,
    [TX_TAG]    NVARCHAR (50)  NULL,
    [TX_MEMO]   NVARCHAR (255) NULL,
    [TX_FILE]   NVARCHAR (255) NULL,
    CONSTRAINT [PK_TAX_REPS] PRIMARY KEY CLUSTERED ([TX_ID] ASC)
);

