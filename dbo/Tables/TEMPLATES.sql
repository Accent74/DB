CREATE TABLE [dbo].[TEMPLATES] (
    [TML_ID]     INT              IDENTITY (1, 1) NOT NULL,
    [TML_GUID]   UNIQUEIDENTIFIER CONSTRAINT [DF_TEMPLATES_TML_GUID] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [FRM_ID]     INT              NULL,
    [TML_NAME]   NVARCHAR (255)   NULL,
    [TML_TYPE]   SMALLINT         NOT NULL,
    [TML_TAG]    NVARCHAR (50)    NULL,
    [TML_MEMO]   NVARCHAR (255)   NULL,
    [TML_REF]    INT              NULL,
    [TML_FILE]   NVARCHAR (255)   NULL,
    [TML_HIDDEN] BIT              CONSTRAINT [DEF_TEMPLATES_TML_HIDDEN] DEFAULT ((0)) NOT NULL,
    [TML_SCRIPT] NTEXT            NULL,
    CONSTRAINT [PK_TEMPLATES] PRIMARY KEY NONCLUSTERED ([TML_ID] ASC),
    CONSTRAINT [FK_TEMPLATES_FORMS] FOREIGN KEY ([FRM_ID]) REFERENCES [dbo].[FORMS] ([FRM_ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[TEMPLATES] NOCHECK CONSTRAINT [FK_TEMPLATES_FORMS];


GO
----------------------------------------
create trigger templates_Dtrig on dbo.TEMPLATES
for delete as
if exists (select * from TML_TREE inner join deleted on TML_TREE.P0=deleted.TML_ID)
begin
   raiserror ('Папку шаблонов удалить нельзя, в ней есть вложенные', 16, 1)
   rollback transaction
end
-- cascade deletes from TML_TREE 
delete TML_TREE from deleted inner join TML_TREE ON deleted.TML_ID = TML_TREE.ID
-- cascade deletes from TML_PARAMS
delete TML_PARAMS from deleted inner join TML_PARAMS ON deleted.TML_ID = TML_PARAMS.TML_ID
-- delete dependent records from REPORTS
delete from REPORTS where  REP_X=7 and REP_X_ID in (select TML_ID from deleted)
-- delete dependent records from EXT_DOCS
delete from EXT_DOCS where EXT_X=6 and EXT_X_ID in (select TML_ID from deleted)
-- cascade deletes from TML_LINKS
delete TML_LINKS from deleted inner join TML_LINKS ON deleted.TML_ID = TML_LINKS.TML_ID_LEFT
delete TML_LINKS from deleted inner join TML_LINKS ON deleted.TML_ID = TML_LINKS.TML_ID_RIGHT
-- delete dependent records from ACL
delete from ACL where KIND=6 and EL_ID in (select TML_ID from deleted)

GO
GRANT SELECT
    ON OBJECT::[dbo].[TEMPLATES] TO [ap_public]
    AS [dbo];

