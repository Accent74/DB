﻿CREATE TABLE [dbo].[FRM_LINKS] (
    [PK]           INT IDENTITY (1, 1) NOT NULL,
    [FRM_ID_LEFT]  INT NULL,
    [FRM_ID_RIGHT] INT NULL,
    CONSTRAINT [PK_FRM_LINKS] PRIMARY KEY CLUSTERED ([PK] ASC),
    CONSTRAINT [FK_FRM_LINKS_FORMS] FOREIGN KEY ([FRM_ID_LEFT]) REFERENCES [dbo].[FORMS] ([FRM_ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_FRM_LINKS_FORMS1] FOREIGN KEY ([FRM_ID_RIGHT]) REFERENCES [dbo].[FORMS] ([FRM_ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[FRM_LINKS] NOCHECK CONSTRAINT [FK_FRM_LINKS_FORMS];


GO
ALTER TABLE [dbo].[FRM_LINKS] NOCHECK CONSTRAINT [FK_FRM_LINKS_FORMS1];


GO
CREATE NONCLUSTERED INDEX [IX_FRM_LINKS_LEFT]
    ON [dbo].[FRM_LINKS]([FRM_ID_LEFT] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_FRM_LINKS_RIGHT]
    ON [dbo].[FRM_LINKS]([FRM_ID_RIGHT] ASC);
