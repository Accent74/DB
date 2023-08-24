CREATE TABLE [dbo].[MISC_TREE] (
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
    CONSTRAINT [PK_MISC_TREE] PRIMARY KEY NONCLUSTERED ([PK] ASC),
    CONSTRAINT [FK_MISC_TREE_MISC] FOREIGN KEY ([ID]) REFERENCES [dbo].[MISC] ([MSC_ID]) NOT FOR REPLICATION,
    CONSTRAINT [UNIQ_MISC_TREE] UNIQUE NONCLUSTERED ([ID] ASC, [P0] ASC)
);


GO
ALTER TABLE [dbo].[MISC_TREE] NOCHECK CONSTRAINT [FK_MISC_TREE_MISC];


GO
CREATE NONCLUSTERED INDEX [IX_MISC_TREE_PARENT]
    ON [dbo].[MISC_TREE]([P0] ASC, [P1] ASC, [P2] ASC, [P3] ASC, [P4] ASC, [P5] ASC, [P6] ASC, [P7] ASC);


GO
GRANT DELETE
    ON OBJECT::[dbo].[MISC_TREE] TO [ap_public]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[MISC_TREE] TO [ap_public]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[MISC_TREE] TO [ap_public]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[MISC_TREE] TO [ap_public]
    AS [dbo];

