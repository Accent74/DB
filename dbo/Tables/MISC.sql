CREATE TABLE [dbo].[MISC] (
    [MSC_ID]    INT              IDENTITY (1, 1) NOT NULL,
    [MSC_GUID]  UNIQUEIDENTIFIER CONSTRAINT [DF_MISC_MSC_GUID] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [MSC_TYPE]  SMALLINT         NOT NULL,
    [MSC_NO]    INT              NULL,
    [MSC_REF]   SMALLINT         NULL,
    [MSC_REFID] INT              NULL,
    [MSC_NAME]  NVARCHAR (255)   NULL,
    [MSC_TAG]   NVARCHAR (50)    NULL,
    [MSC_CODE]  NVARCHAR (50)    NULL,
    [MSC_MEMO]  NVARCHAR (255)   NULL,
    [MSC_STR1]  NVARCHAR (255)   NULL,
    [MSC_STR2]  NVARCHAR (255)   NULL,
    [MSC_STR3]  NVARCHAR (255)   NULL,
    [MSC_LNG1]  INT              NULL,
    [MSC_LNG2]  INT              NULL,
    [MSC_LNG3]  INT              NULL,
    [MSC_CY1]   MONEY            NULL,
    [MSC_CY2]   MONEY            NULL,
    [MSC_CY3]   MONEY            NULL,
    [MSC_DT1]   DATETIME         NULL,
    [MSC_DT2]   DATETIME         NULL,
    [MSC_DT3]   DATETIME         NULL,
    CONSTRAINT [PK_MISC] PRIMARY KEY NONCLUSTERED ([MSC_ID] ASC)
);


GO
----------------------------------------
create trigger misc_Dtrig on MISC
for delete as
if exists (select * from MISC_TREE inner join deleted on MISC_TREE.P0=deleted.MSC_ID)
begin
   raiserror ('Аналитику удалить нельзя, в ней есть вложенные', 16, 1)
   rollback transaction
end
-- cascade deletes from MSC_TREE
delete MISC_TREE from deleted inner join MISC_TREE ON deleted.MSC_ID = MISC_TREE.ID
-- cascade deletes from MSC_PARAMS
delete MISC_PARAMS from deleted inner join MISC_PARAMS ON deleted.MSC_ID = MISC_PARAMS.MSC_ID
-- delete dependent records from REPORTS
delete from REPORTS where  REP_X=6 and REP_X_ID in (select MSC_ID from deleted)
-- delete dependent records from EXT_DOCS
delete from EXT_DOCS where EXT_X=4 and EXT_X_ID in (select MSC_ID from deleted)
-- cascade deletes from MISC_FACTS
delete MISC_FACTS from deleted inner join MISC_FACTS ON deleted.MSC_ID = MISC_FACTS.EL_ID
-- delete dependent records from ACL
delete from ACL where KIND=4 and EL_ID in (select MSC_ID from deleted)

GO
GRANT SELECT
    ON OBJECT::[dbo].[MISC] TO [ap_public]
    AS [dbo];

