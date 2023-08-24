CREATE TABLE [dbo].[DB_PARAM_NAMES] (
    [PRM_ID]    INT              IDENTITY (1, 1) NOT NULL,
    [PRM_GUID]  UNIQUEIDENTIFIER CONSTRAINT [DF_DB_PARAM_NAMES_PRM_GUID] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [PRM_NAME]  NVARCHAR (50)    NOT NULL,
    [NODE_TYPE] INT              NOT NULL,
    [PRM_TYPE]  SMALLINT         NOT NULL,
    [PRM_REF]   INT              NULL,
    [PRM_REFID] INT              NULL,
    [PRM_DESCR] NVARCHAR (64)    NULL,
    CONSTRAINT [PK_DB_PARAM_NAMES] PRIMARY KEY NONCLUSTERED ([PRM_ID] ASC)
);


GO
---------------------------------------------------------------------
create trigger DB_PARAM_NAMES_Dtrig on DB_PARAM_NAMES
for delete as

-- cascade deletes from DB_PARAMS
delete DB_PARAMS from deleted inner join DB_PARAMS ON deleted.PRM_ID = DB_PARAMS.PRM_ID


GO
GRANT DELETE
    ON OBJECT::[dbo].[DB_PARAM_NAMES] TO [ap_public]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DB_PARAM_NAMES] TO [ap_public]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DB_PARAM_NAMES] TO [ap_public]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DB_PARAM_NAMES] TO [ap_public]
    AS [dbo];

