CREATE TABLE [dbo].[SERIES] (
    [SER_ID]     INT            IDENTITY (1, 1) NOT NULL,
    [ENT_ID]     INT            NOT NULL,
    [SER_NAME]   NVARCHAR (255) NULL,
    [SER_CODE]   NVARCHAR (50)  NULL,
    [SER_NUMBER] NVARCHAR (50)  NULL,
    [SER_TAG]    NVARCHAR (50)  NULL,
    [SER_MEMO]   NVARCHAR (255) NULL,
    [SER_DATE1]  DATETIME       NULL,
    [SER_DATE2]  DATETIME       NULL,
    [SER_DATE3]  DATETIME       NULL,
    [SER_LONG1]  INT            NULL,
    [SER_LONG2]  INT            NULL,
    [SER_LONG3]  INT            NULL,
    [SER_CY1]    MONEY          NULL,
    [SER_CY2]    MONEY          NULL,
    [SER_CY3]    MONEY          NULL,
    [SER_SYSTEM] INT            NULL,
    CONSTRAINT [PK_SER_ID] PRIMARY KEY CLUSTERED ([SER_ID] ASC),
    CONSTRAINT [FK_SERIES_ENTITIES] FOREIGN KEY ([ENT_ID]) REFERENCES [dbo].[ENTITIES] ([ENT_ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[SERIES] NOCHECK CONSTRAINT [FK_SERIES_ENTITIES];


GO
CREATE NONCLUSTERED INDEX [ix_series_ent_id]
    ON [dbo].[SERIES]([ENT_ID] ASC);


GO
-----------------------------------------
create trigger SERIES_Dtrig on SERIES
for delete as

-- cascade deletes from SER_PARAMS
delete SER_PARAMS from deleted inner join SER_PARAMS ON deleted.SER_ID = SER_PARAMS.SER_ID

