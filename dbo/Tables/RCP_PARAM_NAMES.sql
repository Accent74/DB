CREATE TABLE [dbo].[RCP_PARAM_NAMES] (
    [PRM_ID]    INT              IDENTITY (1, 1) NOT NULL,
    [PRM_GUID]  UNIQUEIDENTIFIER CONSTRAINT [DF_RCP_PARAM_NAMES_PRM_GUID] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [PRM_NAME]  NVARCHAR (50)    NOT NULL,
    [NODE_TYPE] INT              NOT NULL,
    [PRM_TYPE]  SMALLINT         NOT NULL,
    [PRM_REF]   INT              NULL,
    [PRM_REFID] INT              NULL,
    [PRM_DESCR] NVARCHAR (64)    NULL,
    CONSTRAINT [PK_RCP_PARAM_NAMES] PRIMARY KEY CLUSTERED ([PRM_ID] ASC)
);


GO
-----------------------------------------
create trigger RCP_PARAM_NAMES_Dtrig on RCP_PARAM_NAMES
for delete as

-- cascade deletes from RCP_PARAMS
delete RCP_PARAMS from deleted inner join RCP_PARAMS ON deleted.PRM_ID = RCP_PARAMS.PRM_ID

