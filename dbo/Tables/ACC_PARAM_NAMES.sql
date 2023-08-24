CREATE TABLE [dbo].[ACC_PARAM_NAMES] (
    [PRM_ID]    INT              IDENTITY (1, 1) NOT NULL,
    [PRM_GUID]  UNIQUEIDENTIFIER CONSTRAINT [DF_ACC_PARAM_NAMES_PRM_GUID] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [PRM_NAME]  NVARCHAR (50)    NOT NULL,
    [NODE_TYPE] INT              NOT NULL,
    [PRM_TYPE]  SMALLINT         NOT NULL,
    [PRM_REF]   INT              NULL,
    [PRM_REFID] INT              NULL,
    [PRM_DESCR] NVARCHAR (64)    NULL,
    CONSTRAINT [PK_ACC_PARAM_NAMES] PRIMARY KEY CLUSTERED ([PRM_ID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_ACC_PARAM_NAMES_GUID]
    ON [dbo].[ACC_PARAM_NAMES]([PRM_GUID] ASC);


GO
---------------------------------------------------------------------
create trigger ACC_PARAM_NAMES_Dtrig on ACC_PARAM_NAMES
for delete as

-- cascade deletes from ACC_PARAMS
delete ACC_PARAMS from deleted inner join ACC_PARAMS ON deleted.PRM_ID = ACC_PARAMS.PRM_ID


GO
GRANT DELETE
    ON OBJECT::[dbo].[ACC_PARAM_NAMES] TO [ap_public]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ACC_PARAM_NAMES] TO [ap_public]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ACC_PARAM_NAMES] TO [ap_public]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ACC_PARAM_NAMES] TO [ap_public]
    AS [dbo];

