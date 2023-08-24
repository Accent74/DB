CREATE TABLE [dbo].[PRC_NAMES] (
    [PRC_ID]      INT            IDENTITY (1, 1) NOT NULL,
    [PRC_PROGID]  NVARCHAR (50)  NULL,
    [PRC_NAME]    NVARCHAR (255) NULL,
    [CRC_ID]      INT            NOT NULL,
    [PRC_FORMULA] NVARCHAR (255) NULL,
    [PRC_MEMO]    NVARCHAR (255) NULL,
    [PRC_TAG]     NVARCHAR (50)  NULL,
    [UN_ID]       INT            NULL,
    CONSTRAINT [PK_PRC_NAMES] PRIMARY KEY NONCLUSTERED ([PRC_ID] ASC),
    CONSTRAINT [FK_PRC_NAMES_CURRENCIES] FOREIGN KEY ([CRC_ID]) REFERENCES [dbo].[CURRENCIES] ([CRC_ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_PRC_NAMES_UNITS] FOREIGN KEY ([UN_ID]) REFERENCES [dbo].[UNITS] ([UN_ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[PRC_NAMES] NOCHECK CONSTRAINT [FK_PRC_NAMES_CURRENCIES];


GO
ALTER TABLE [dbo].[PRC_NAMES] NOCHECK CONSTRAINT [FK_PRC_NAMES_UNITS];


GO
---------------------------------------------------------------------
create trigger prcnames_Dtrig on dbo.PRC_NAMES
for delete as

-- cascade deletes from PRL_PRICES
delete PRL_PRICES from deleted inner join PRL_PRICES ON deleted.PRC_ID = PRL_PRICES.PRC_ID
-- cascade deletes from PRC_CONTENTS
delete PRC_CONTENTS from deleted inner join PRC_CONTENTS on deleted.PRC_ID=PRC_CONTENTS.PRC_ID

