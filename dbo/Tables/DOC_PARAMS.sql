﻿CREATE TABLE [dbo].[DOC_PARAMS] (
    [DOC_ID]     INT            NOT NULL,
    [PRM_ID]     INT            NOT NULL,
    [PRM_LONG]   INT            NULL,
    [PRM_STRING] NVARCHAR (255) NULL,
    [PRM_DOUBLE] FLOAT (53)     NULL,
    [PRM_DATE]   DATETIME       NULL,
    [PRM_CY]     MONEY          NULL,
    CONSTRAINT [PK_DOC_PARAMS] PRIMARY KEY NONCLUSTERED ([DOC_ID] ASC, [PRM_ID] ASC),
    CONSTRAINT [FK_DOC_PARAMS_DOC_PARAM_NAMES] FOREIGN KEY ([PRM_ID]) REFERENCES [dbo].[DOC_PARAM_NAMES] ([PRM_ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_DOC_PARAMS_DOCUMENTS] FOREIGN KEY ([DOC_ID]) REFERENCES [dbo].[DOCUMENTS] ([DOC_ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[DOC_PARAMS] NOCHECK CONSTRAINT [FK_DOC_PARAMS_DOC_PARAM_NAMES];


GO
ALTER TABLE [dbo].[DOC_PARAMS] NOCHECK CONSTRAINT [FK_DOC_PARAMS_DOCUMENTS];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DOC_PARAMS] TO [ap_public]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DOC_PARAMS] TO [ap_public]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DOC_PARAMS] TO [ap_public]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DOC_PARAMS] TO [ap_public]
    AS [dbo];

