CREATE TABLE [dbo].[ACCOUNTS] (
    [ACC_ID]      INT              IDENTITY (1, 1) NOT NULL,
    [ACC_GUID]    UNIQUEIDENTIFIER CONSTRAINT [DF_ACCOUNTS_ACC_GUID] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [ACC_PLAN]    INT              NOT NULL,
    [ACC_CODE]    NVARCHAR (50)    NOT NULL,
    [ACC_PL_CODE] NVARCHAR (50)    NOT NULL,
    [ACC_NAME]    NVARCHAR (255)   NULL,
    [ACC_TYPE]    SMALLINT         NOT NULL,
    [ACC_S_TYPE]  SMALLINT         NULL,
    [ACC_T_TYPE]  SMALLINT         NULL,
    [ACC_MEMO]    NVARCHAR (255)   NULL,
    [ACC_TAG]     NVARCHAR (50)    NULL,
    [ACC_REM]     SMALLINT         NULL,
    [ADT_ID]      INT              NULL,
    CONSTRAINT [PK_ACCOUNTS] PRIMARY KEY NONCLUSTERED ([ACC_ID] ASC)
);


GO
----------------------------------------
create trigger accounts_Dtrig on ACCOUNTS
for delete as
-- check journal
if exists (select * from JOURNAL inner join deleted on JOURNAL.ACC_DB=deleted.ACC_ID or JOURNAL.ACC_CR=deleted.ACC_ID) 
begin
   raiserror ('Счет удалить нельзя, он используется в журнале операций', 16, 1)
   rollback transaction
end
if exists (select * from ACC_TREE inner join deleted on ACC_TREE.P0=deleted.ACC_ID)
begin
   raiserror ('Счет удалить нельзя, в нем есть вложенные', 16, 1)
   rollback transaction
end
-- cascade deletes from ACC_TREE 
delete ACC_TREE from deleted inner join ACC_TREE ON deleted.ACC_ID = ACC_TREE.ID
-- cascade deletes from ACC_PARAMS
delete ACC_PARAMS from deleted inner join ACC_PARAMS ON deleted.ACC_ID = ACC_PARAMS.ACC_ID
-- delete dependent records from REPORTS
delete from REPORTS where  REP_X=0 and REP_X_ID in (select ACC_ID from deleted)
-- delete dependent records from EXT_DOCS
delete from EXT_DOCS where EXT_X=1 and EXT_X_ID in (select ACC_ID from deleted)
-- delete dependent records from ACL
delete from ACL where KIND=1 and EL_ID in (select ACC_ID from deleted)
-- update entities with this account
update ENTITIES set ENTITIES.ACC_ID=null where ENTITIES.ACC_ID in (select deleted.ACC_ID from deleted)
-- update AG_BANKS with this ACCOUNT
update AG_BANKS set AG_BANKS.ACC_ID=null where AG_BANKS.ACC_ID in (select deleted.ACC_ID from deleted)

GO
GRANT SELECT
    ON OBJECT::[dbo].[ACCOUNTS] TO [ap_public]
    AS [dbo];

