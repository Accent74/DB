﻿CREATE TABLE [dbo].[ACL] (
    [ACL_ID] INT           IDENTITY (1, 1) NOT NULL,
    [UID]    NVARCHAR (50) NOT NULL,
    [KIND]   INT           NOT NULL,
    [EL_ID]  INT           NOT NULL,
    [MASK1]  INT           NULL,
    [MASK2]  INT           NULL,
    CONSTRAINT [PK_ACL] PRIMARY KEY CLUSTERED ([ACL_ID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_ACL_COMBO]
    ON [dbo].[ACL]([UID] ASC, [KIND] ASC, [EL_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ACL_UID]
    ON [dbo].[ACL]([UID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ACL_KIND_EL_KIND]
    ON [dbo].[ACL]([KIND] ASC, [EL_ID] ASC);

