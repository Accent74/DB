CREATE TABLE [dbo].[BINDERS] (
    [BIND_ID]   INT              IDENTITY (1, 1) NOT NULL,
    [BIND_GUID] UNIQUEIDENTIFIER CONSTRAINT [DF_BINDERS_BIND_GUID] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [BIND_TYPE] SMALLINT         NOT NULL,
    [BIND_NAME] NVARCHAR (255)   NULL,
    [BIND_TAG]  NVARCHAR (50)    NULL,
    [BIND_MEMO] NVARCHAR (255)   NULL,
    CONSTRAINT [PK_BINDERS] PRIMARY KEY NONCLUSTERED ([BIND_ID] ASC)
);


GO
--------------------------------------
create trigger binders_Dtrig on BINDERS
for delete as
if exists (select * from BIND_TREE inner join deleted on BIND_TREE.P0=deleted.BIND_ID)
begin
   raiserror ('Подшивку удалить нельзя, в ней есть вложенные', 16, 1)
   rollback transaction
end
-- cascade deletes from BIND_TREE 
delete BIND_TREE from deleted inner join BIND_TREE ON deleted.BIND_ID = BIND_TREE.ID
-- cascade deletes from BIND_PARAMS
delete BIND_PARAMS from deleted inner join BIND_PARAMS ON deleted.BIND_ID = BIND_PARAMS.BIND_ID
-- delete dependent records from REPORTS
delete from REPORTS where  REP_X=5 and REP_X_ID in (select BIND_ID from deleted)
-- delete dependent records from EXT_DOCS
delete from EXT_DOCS where EXT_X=5 and EXT_X_ID in (select BIND_ID from deleted)
-- cascade deletes from BIND_TREE 
delete BIND_DOCS from deleted inner join BIND_DOCS ON deleted.BIND_ID = BIND_DOCS.BIND_ID
-- delete dependent records from ACL
delete from ACL where KIND=5 and EL_ID in (select BIND_ID from deleted)

GO
GRANT SELECT
    ON OBJECT::[dbo].[BINDERS] TO [ap_public]
    AS [dbo];

