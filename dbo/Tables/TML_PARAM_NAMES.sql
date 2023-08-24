CREATE TABLE [dbo].[TML_PARAM_NAMES] (
    [PRM_ID]    INT              IDENTITY (1, 1) NOT NULL,
    [PRM_GUID]  UNIQUEIDENTIFIER CONSTRAINT [DF_TML_PARAM_NAMES_PRM_GUID] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [PRM_NAME]  NVARCHAR (50)    NOT NULL,
    [NODE_TYPE] INT              NOT NULL,
    [PRM_TYPE]  SMALLINT         NOT NULL,
    [PRM_REF]   INT              NULL,
    [PRM_REFID] INT              NULL,
    [PRM_DESCR] NVARCHAR (64)    NULL,
    CONSTRAINT [PK_TML_PARAM_NAMES] PRIMARY KEY NONCLUSTERED ([PRM_ID] ASC)
);


GO
----------------------------------------
create trigger TML_PARAM_NAMES_Dtrig on TML_PARAM_NAMES
for delete as

-- cascade deletes from TML_PARAMS
delete TML_PARAMS from deleted inner join TML_PARAMS ON deleted.PRM_ID = TML_PARAMS.PRM_ID


GO
GRANT DELETE
    ON OBJECT::[dbo].[TML_PARAM_NAMES] TO [ap_public]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[TML_PARAM_NAMES] TO [ap_public]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[TML_PARAM_NAMES] TO [ap_public]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[TML_PARAM_NAMES] TO [ap_public]
    AS [dbo];

