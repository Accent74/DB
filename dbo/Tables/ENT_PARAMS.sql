﻿CREATE TABLE [dbo].[ENT_PARAMS] (
    [ENT_ID]     INT            NOT NULL,
    [PRM_ID]     INT            NOT NULL,
    [PRM_LONG]   INT            NULL,
    [PRM_STRING] NVARCHAR (255) NULL,
    [PRM_DOUBLE] FLOAT (53)     NULL,
    [PRM_DATE]   DATETIME       NULL,
    [PRM_CY]     MONEY          NULL,
    CONSTRAINT [PK_ENT_PARAMS] PRIMARY KEY NONCLUSTERED ([ENT_ID] ASC, [PRM_ID] ASC),
    CONSTRAINT [FK_ENT_PARAMS_ENT_PARAM_NAMES] FOREIGN KEY ([PRM_ID]) REFERENCES [dbo].[ENT_PARAM_NAMES] ([PRM_ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ENT_PARAMS_ENTITIES] FOREIGN KEY ([ENT_ID]) REFERENCES [dbo].[ENTITIES] ([ENT_ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[ENT_PARAMS] NOCHECK CONSTRAINT [FK_ENT_PARAMS_ENT_PARAM_NAMES];


GO
ALTER TABLE [dbo].[ENT_PARAMS] NOCHECK CONSTRAINT [FK_ENT_PARAMS_ENTITIES];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ENT_PARAMS] TO [ap_public]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ENT_PARAMS] TO [ap_public]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ENT_PARAMS] TO [ap_public]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ENT_PARAMS] TO [ap_public]
    AS [dbo];

