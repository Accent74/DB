CREATE TABLE [dbo].[AGENTS] (
    [AG_ID]         INT              IDENTITY (1, 1) NOT NULL,
    [AG_GUID]       UNIQUEIDENTIFIER CONSTRAINT [DF_AGENTS_AG_GUID] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [AG_NAME]       NVARCHAR (255)   NOT NULL,
    [AG_TYPE]       SMALLINT         NOT NULL,
    [AG_TAG]        NVARCHAR (50)    NULL,
    [AG_MEMO]       NVARCHAR (255)   NULL,
    [AG_CODE]       NVARCHAR (50)    NULL,
    [AG_TABNO]      NVARCHAR (50)    NULL,
    [AG_ADDRESS]    NVARCHAR (255)   NULL,
    [AG_PHONE]      NVARCHAR (50)    NULL,
    [AG_PASSPORT]   NVARCHAR (255)   NULL,
    [AG_PAYMEMO]    NVARCHAR (255)   NULL,
    [AG_VATNO]      NVARCHAR (50)    NULL,
    [AG_REGNO]      NVARCHAR (50)    NULL,
    [AG_DATE1]      DATETIME         NULL,
    [AG_DATE2]      DATETIME         NULL,
    [AG_EMAIL]      NVARCHAR (255)   NULL,
    [AG_WWW]        NVARCHAR (255)   NULL,
    [AG_CONTACT]    NVARCHAR (255)   NULL,
    [AG_COUNTRY]    NVARCHAR (50)    NULL,
    [AG_REF]        INT              NULL,
    [AG_ACC_X]      NVARCHAR (8)     NULL,
    [AG_DISAB]      INT              NULL,
    [AG_AGRMNT]     INT              NULL,
    [AG_LastUpdate] DATETIME         NULL,
    [AG_Created]    DATETIME         CONSTRAINT [DF_AGENTS_AG_Created] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_AGENTS] PRIMARY KEY NONCLUSTERED ([AG_ID] ASC)
);


GO
-----------------------------------------
create trigger agents_Dtrig on dbo.AGENTS 
for delete as
-- check journal
if exists (select * from JOURNAL inner join deleted on JOURNAL.J_AG1=deleted.AG_ID or JOURNAL.J_AG2=deleted.AG_ID) 
begin
   raiserror ('Корреспондента удалить нельзя, он используется в журнале операций', 16, 1)
   rollback transaction
end
if exists (select * from AG_TREE inner join deleted on AG_TREE.P0=deleted.AG_ID)
begin
   raiserror ('Корреспондента удалить нельзя, в нем есть вложенные', 16, 1)
   rollback transaction
end
-- cascade deletes from AG_TREE 
delete AG_TREE from deleted inner join AG_TREE ON deleted.AG_ID = AG_TREE.ID
-- cascade deletes from AG_PARAMS
delete AG_PARAMS from deleted inner join AG_PARAMS ON deleted.AG_ID = AG_PARAMS.AG_ID
-- cascade deletes from AG_BANKS
delete AG_BANKS from deleted inner join AG_BANKS ON deleted.AG_ID = AG_BANKS.AG_ID
-- delete dependent records from REPORTS
delete from REPORTS where  REP_X=1 and REP_X_ID in (select AG_ID from deleted)
-- delete dependent records from EXT_DOCS
delete from EXT_DOCS where EXT_X=2 and EXT_X_ID in (select AG_ID from deleted)
-- cascade deletes from AG_FACTS
delete AG_FACTS from deleted inner join AG_FACTS ON deleted.AG_ID = AG_FACTS.EL_ID
-- delete dependent records from ACL
delete from ACL where KIND=2 and EL_ID in (select AG_ID from deleted)
-- update RP_CONTENTS with this AGENT
update RP_CONTENTS set RP_CONTENTS.AG_ID=null where RP_CONTENTS.AG_ID in (select deleted.AG_ID from deleted)

GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER agents_Utrig
   ON  dbo.Agents 
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
   
   update agents
   set AG_LastUpdate = getdate()
   from agents as a
   inner join inserted as i on a.ag_id = i.ag_id

    -- Insert statements for trigger here

END

GO
GRANT SELECT
    ON OBJECT::[dbo].[AGENTS] TO [ap_public]
    AS [dbo];

