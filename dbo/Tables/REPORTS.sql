CREATE TABLE [dbo].[REPORTS] (
    [REP_ID]      INT              IDENTITY (1, 1) NOT NULL,
    [REP_GUID]    UNIQUEIDENTIFIER CONSTRAINT [DF_REPORTS_REP_GUID] DEFAULT (newid()) ROWGUIDCOL NULL,
    [REP_X]       SMALLINT         NOT NULL,
    [REP_X_ID]    INT              NOT NULL,
    [REP_NAME]    NVARCHAR (255)   NULL,
    [REP_TYPE]    SMALLINT         NOT NULL,
    [REP_SUBTYPE] SMALLINT         NULL,
    [REP_PS1]     NVARCHAR (255)   NULL,
    [REP_PS2]     NVARCHAR (255)   NULL,
    [REP_PS3]     NVARCHAR (255)   NULL,
    [REP_PS4]     NVARCHAR (255)   NULL,
    [REP_PS5]     NVARCHAR (255)   NULL,
    [REP_PS6]     NVARCHAR (255)   NULL,
    [REP_PL1]     INT              NULL,
    [REP_PL2]     INT              NULL,
    [REP_PL3]     INT              NULL,
    [REP_PL4]     INT              NULL,
    [REP_PL5]     INT              NULL,
    [REP_MEMO]    NVARCHAR (255)   NULL,
    [APP_TYPE]    INT              NULL,
    CONSTRAINT [PK_REPORTS] PRIMARY KEY NONCLUSTERED ([REP_ID] ASC)
);


GO
-----------------------------------------
create trigger reports_Dtrig on [dbo].[REPORTS] 
for delete as
-- delete dependent records from ACL
delete from ACL where KIND=10 and EL_ID in (select REP_ID from deleted)
