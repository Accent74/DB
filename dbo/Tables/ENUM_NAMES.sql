CREATE TABLE [dbo].[ENUM_NAMES] (
    [ENN_ID]   INT           IDENTITY (1, 1) NOT NULL,
    [ENN_NAME] NVARCHAR (50) NOT NULL,
    [ENN_TAG]  NVARCHAR (50) NULL,
    CONSTRAINT [PK_ENUM_NAMES] PRIMARY KEY CLUSTERED ([ENN_ID] ASC)
);


GO
-----------------------------------------
create trigger ENUM_NAMES_Dtrig on ENUM_NAMES
for delete as

-- cascade deletes from ENUMS
delete ENUMS from deleted inner join ENUMS ON deleted.ENN_ID = ENUMS.ENN_ID

