CREATE TABLE [dbo].[FOLDERS] (
    [FLD_ID]      INT              IDENTITY (1, 1) NOT NULL,
    [FLD_GUID]    UNIQUEIDENTIFIER CONSTRAINT [DF_FOLDERS_FLD_GUID] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [FLD_NAME]    NVARCHAR (255)   NOT NULL,
    [FLD_TAG]     NVARCHAR (50)    NULL,
    [FLD_MEMO]    NVARCHAR (255)   NULL,
    [TML_ID]      INT              NULL,
    [FRM_ID]      INT              NULL,
    [FLD_SYSTEM]  INT              NULL,
    [FLD_SYSCODE] NVARCHAR (4)     NULL,
    CONSTRAINT [PK_FOLDERS] PRIMARY KEY NONCLUSTERED ([FLD_ID] ASC),
    CONSTRAINT [FK_FOLDERS_FORMS] FOREIGN KEY ([FRM_ID]) REFERENCES [dbo].[FORMS] ([FRM_ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[FOLDERS] NOCHECK CONSTRAINT [FK_FOLDERS_FORMS];


GO
CREATE NONCLUSTERED INDEX [IX_FOLDERS_GUID]
    ON [dbo].[FOLDERS]([FLD_GUID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_FOLDERS_SYSCODE]
    ON [dbo].[FOLDERS]([FLD_SYSCODE] ASC);


GO
----------------------------------------
create trigger folders_Dtrig on FOLDERS 
for delete as
if exists (select * from FLD_TREE inner join deleted on FLD_TREE.P0=deleted.FLD_ID)
begin
   raiserror ('Папку удалить нельзя, в ней есть вложенные', 16, 1)
   rollback transaction
end
-- cascade deletes from FLD_TREE 
delete FLD_TREE from deleted inner join FLD_TREE ON deleted.FLD_ID = FLD_TREE.ID
-- cascade deletes from FLD_PARAMS
delete FLD_PARAMS from deleted inner join FLD_PARAMS ON deleted.FLD_ID = FLD_PARAMS.FLD_ID
-- delete dependent records from REPORTS
delete from REPORTS where  REP_X=4 and REP_X_ID in (select FLD_ID from deleted)
-- delete dependent records from EXT_DOCS
delete from EXT_DOCS where EXT_X=0 and EXT_X_ID in (select FLD_ID from deleted)
-- delete dependent records from ACL
delete from ACL where KIND=0 and EL_ID in (select FLD_ID from deleted)
-- clear FORMS.FLD_ID
update FORMS set FORMS.FLD_ID=null where FORMS.FLD_ID in (select FLD_ID from deleted)

GO
GRANT SELECT
    ON OBJECT::[dbo].[FOLDERS] TO [ap_public]
    AS [dbo];

