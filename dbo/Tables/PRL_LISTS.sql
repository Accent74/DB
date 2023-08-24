CREATE TABLE [dbo].[PRL_LISTS] (
    [PRL_ID]    INT            IDENTITY (1, 1) NOT NULL,
    [PRL_NAME]  NVARCHAR (50)  NULL,
    [PRL_MEMO]  NVARCHAR (255) NULL,
    [PRL_FLAGS] INT            NULL,
    CONSTRAINT [PK_PRL_LISTS] PRIMARY KEY NONCLUSTERED ([PRL_ID] ASC)
);


GO

---------------------------------------------------------------------
create trigger prllists_Dtrig on dbo.PRL_LISTS
for delete as

-- cascade deletes from PRL_PRICES
delete PRL_PRICES from deleted inner join PRL_PRICES ON deleted.PRL_ID = PRL_PRICES.PRL_ID

