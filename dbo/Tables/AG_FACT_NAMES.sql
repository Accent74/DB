CREATE TABLE [dbo].[AG_FACT_NAMES] (
    [FA_ID]     INT           IDENTITY (1, 1) NOT NULL,
    [FA_NAME]   NVARCHAR (50) NOT NULL,
    [NODE_TYPE] INT           NOT NULL,
    [FA_TYPE]   SMALLINT      NOT NULL,
    [FA_REF]    INT           NULL,
    [FA_REFID]  INT           NULL,
    [FA_DESCR]  NVARCHAR (64) NULL,
    CONSTRAINT [PK_AG_FACT_NAMES] PRIMARY KEY CLUSTERED ([FA_ID] ASC)
);


GO
-----------------------------------------
CREATE TRIGGER AG_FACT_NAMES_DTrig ON [dbo].[AG_FACT_NAMES] 
FOR DELETE 
AS
-- cascade deletes from AG_FACTS
delete AG_FACTS from deleted inner join AG_FACTS ON deleted.FA_ID = AG_FACTS.FA_ID


GO
GRANT DELETE
    ON OBJECT::[dbo].[AG_FACT_NAMES] TO [ap_public]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[AG_FACT_NAMES] TO [ap_public]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[AG_FACT_NAMES] TO [ap_public]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[AG_FACT_NAMES] TO [ap_public]
    AS [dbo];

