CREATE TABLE [dbo].[DOC_FACT_NAMES] (
    [FA_ID]     INT           IDENTITY (1, 1) NOT NULL,
    [FA_NAME]   NVARCHAR (50) NOT NULL,
    [NODE_TYPE] INT           NOT NULL,
    [FA_TYPE]   SMALLINT      NOT NULL,
    [FA_REF]    INT           NULL,
    [FA_REFID]  INT           NULL,
    [FA_DESCR]  NVARCHAR (64) NULL,
    CONSTRAINT [PK_DOC_FACT_NAMES] PRIMARY KEY CLUSTERED ([FA_ID] ASC)
);


GO
-----------------------------------------
create trigger DOC_FACT_NAMES_Dtrig on DOC_FACT_NAMES
for delete as

-- cascade deletes from DOC_FACTS
delete DOC_FACTS from deleted inner join DOC_FACTS ON deleted.FA_ID = DOC_FACTS.FA_ID

