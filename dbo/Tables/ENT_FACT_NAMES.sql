CREATE TABLE [dbo].[ENT_FACT_NAMES] (
    [FA_ID]     INT           IDENTITY (1, 1) NOT NULL,
    [FA_NAME]   NVARCHAR (50) NOT NULL,
    [NODE_TYPE] INT           NOT NULL,
    [FA_TYPE]   SMALLINT      NOT NULL,
    [FA_REF]    INT           NULL,
    [FA_REFID]  INT           NULL,
    [FA_DESCR]  NVARCHAR (64) NULL,
    CONSTRAINT [PK_ENT_FACT_NAMES] PRIMARY KEY CLUSTERED ([FA_ID] ASC)
);


GO
-----------------------------------------
CREATE TRIGGER ENT_FACT_NAMES_DTrig ON [dbo].[ENT_FACT_NAMES] 
FOR DELETE 
AS
-- cascade deletes from ENT_FACTS
delete ENT_FACTS from deleted inner join ENT_FACTS ON deleted.FA_ID = ENT_FACTS.FA_ID


GO
GRANT DELETE
    ON OBJECT::[dbo].[ENT_FACT_NAMES] TO [ap_public]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ENT_FACT_NAMES] TO [ap_public]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ENT_FACT_NAMES] TO [ap_public]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ENT_FACT_NAMES] TO [ap_public]
    AS [dbo];

