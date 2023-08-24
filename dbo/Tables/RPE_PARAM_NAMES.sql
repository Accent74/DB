CREATE TABLE [dbo].[RPE_PARAM_NAMES] (
    [PRM_ID]    INT              IDENTITY (1, 1) NOT NULL,
    [PRM_GUID]  UNIQUEIDENTIFIER CONSTRAINT [DF_RPE_PARAM_NAMES_PRM_GUID] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [PRM_NAME]  NVARCHAR (50)    NOT NULL,
    [NODE_TYPE] INT              NOT NULL,
    [PRM_TYPE]  SMALLINT         NOT NULL,
    [PRM_REF]   INT              NULL,
    [PRM_REFID] INT              NULL,
    [PRM_DESCR] NVARCHAR (64)    NULL,
    CONSTRAINT [PK_RPE_PARAM_NAMES] PRIMARY KEY CLUSTERED ([PRM_ID] ASC)
);


GO
-----------------------------------------
create trigger RPE_PARAM_NAMES_Dtrig on RPE_PARAM_NAMES
for delete as
-- cascade deletes from RPE_PARAMS
delete RPE_PARAMS from deleted inner join RPE_PARAMS ON deleted.PRM_ID = RPE_PARAMS.PRM_ID
