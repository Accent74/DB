CREATE TABLE [dbo].[SYS_LOG] (
    [LOGID]      INT              IDENTITY (1, 1) NOT NULL,
    [LOG_DATE]   DATETIME         CONSTRAINT [DF_SYS_LOG_LOG_DATE] DEFAULT (getdate()) NOT NULL,
    [UID]        SMALLINT         CONSTRAINT [DF_SYS_LOG_UID] DEFAULT (user_id()) NOT NULL,
    [ITEM]       NCHAR (1)        NOT NULL,
    [SYS_ACTION] NCHAR (1)        NOT NULL,
    [ITEM_ID]    INT              NULL,
    [ITEM_DATE]  DATETIME         NULL,
    [ITEM_CY]    MONEY            NULL,
    [ITEM_STR1]  NVARCHAR (50)    NULL,
    [ITEM_STR2]  NVARCHAR (50)    NULL,
    [GUID]       UNIQUEIDENTIFIER NULL,
    [FLAGS1]     INT              NULL,
    CONSTRAINT [PK_SYS_LOG] PRIMARY KEY NONCLUSTERED ([LOGID] ASC)
);

