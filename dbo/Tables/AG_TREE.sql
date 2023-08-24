CREATE TABLE [dbo].[AG_TREE] (
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
    CONSTRAINT [PK_AG_TREE] PRIMARY KEY NONCLUSTERED ([PK] ASC),
    CONSTRAINT [FK_AG_TREE_AGENTS] FOREIGN KEY ([ID]) REFERENCES [dbo].[AGENTS] ([AG_ID]) NOT FOR REPLICATION,
    CONSTRAINT [UNIQ_AG_TREE] UNIQUE NONCLUSTERED ([ID] ASC, [P0] ASC)
);


GO
ALTER TABLE [dbo].[AG_TREE] NOCHECK CONSTRAINT [FK_AG_TREE_AGENTS];


GO
CREATE NONCLUSTERED INDEX [IX_AG_TREE_PARENT]
    ON [dbo].[AG_TREE]([P0] ASC, [P1] ASC, [P2] ASC, [P3] ASC, [P4] ASC, [P5] ASC, [P6] ASC, [P7] ASC);


GO
GRANT DELETE
    ON OBJECT::[dbo].[AG_TREE] TO [ap_public]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[AG_TREE] TO [ap_public]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[AG_TREE] TO [ap_public]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[AG_TREE] TO [ap_public]
    AS [dbo];

