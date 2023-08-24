CREATE TABLE [dbo].[TML_TREE] (
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
    CONSTRAINT [PK_TML_TREE] PRIMARY KEY NONCLUSTERED ([PK] ASC),
    CONSTRAINT [FK_TML_TREE_TEMPLATES] FOREIGN KEY ([ID]) REFERENCES [dbo].[TEMPLATES] ([TML_ID]),
    CONSTRAINT [UNIQ_TML_TREE] UNIQUE NONCLUSTERED ([ID] ASC, [P0] ASC)
);


GO
ALTER TABLE [dbo].[TML_TREE] NOCHECK CONSTRAINT [FK_TML_TREE_TEMPLATES];


GO
CREATE NONCLUSTERED INDEX [IX_TML_TREE_ID]
    ON [dbo].[TML_TREE]([ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_TML_TREE_PARENT]
    ON [dbo].[TML_TREE]([P0] ASC, [P1] ASC, [P2] ASC, [P3] ASC, [P4] ASC, [P5] ASC, [P6] ASC, [P7] ASC);


GO
GRANT DELETE
    ON OBJECT::[dbo].[TML_TREE] TO [ap_public]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[TML_TREE] TO [ap_public]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[TML_TREE] TO [ap_public]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[TML_TREE] TO [ap_public]
    AS [dbo];

