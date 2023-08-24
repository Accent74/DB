CREATE TABLE [dbo].[ENT_TREE] (
    [PK]       INT        IDENTITY (1, 1) NOT NULL,
    [ID]       INT        NOT NULL,
    [SHORTCUT] BIT        NOT NULL,
    [DATA1]    FLOAT (53) NULL,
    [P0]       INT        NOT NULL,
    [P1]       INT        NOT NULL,
    [P2]       INT        NOT NULL,
    [P3]       INT        NOT NULL,
    [P4]       INT        NOT NULL,
    [P5]       INT        NOT NULL,
    [P6]       INT        NOT NULL,
    [P7]       INT        NOT NULL,
    CONSTRAINT [PK_ENT_TREE] PRIMARY KEY NONCLUSTERED ([PK] ASC),
    CONSTRAINT [FK_ENT_TREE_ENTITIES] FOREIGN KEY ([ID]) REFERENCES [dbo].[ENTITIES] ([ENT_ID]) NOT FOR REPLICATION,
    CONSTRAINT [UNIQ_ENT_TREE] UNIQUE NONCLUSTERED ([ID] ASC, [P0] ASC)
);


GO
ALTER TABLE [dbo].[ENT_TREE] NOCHECK CONSTRAINT [FK_ENT_TREE_ENTITIES];


GO
CREATE NONCLUSTERED INDEX [IX_ENT_TREE_PARENT]
    ON [dbo].[ENT_TREE]([P0] ASC, [P1] ASC, [P2] ASC, [P3] ASC, [P4] ASC, [P5] ASC, [P6] ASC, [P7] ASC);


GO
GRANT DELETE
    ON OBJECT::[dbo].[ENT_TREE] TO [ap_public]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ENT_TREE] TO [ap_public]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ENT_TREE] TO [ap_public]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ENT_TREE] TO [ap_public]
    AS [dbo];

