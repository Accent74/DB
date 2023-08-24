CREATE TABLE [dbo].[ACC_TREE] (
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
    CONSTRAINT [PK_ACC_TREE] PRIMARY KEY NONCLUSTERED ([PK] ASC),
    CONSTRAINT [FK_ACC_TREE_ACCOUNTS] FOREIGN KEY ([ID]) REFERENCES [dbo].[ACCOUNTS] ([ACC_ID]) NOT FOR REPLICATION,
    CONSTRAINT [UNIQ_ACC_TREE] UNIQUE NONCLUSTERED ([ID] ASC, [P0] ASC)
);


GO
ALTER TABLE [dbo].[ACC_TREE] NOCHECK CONSTRAINT [FK_ACC_TREE_ACCOUNTS];


GO
CREATE NONCLUSTERED INDEX [IX_ACC_TREE_PARENT]
    ON [dbo].[ACC_TREE]([P0] ASC, [P1] ASC, [P2] ASC, [P3] ASC, [P4] ASC, [P5] ASC, [P6] ASC, [P7] ASC);


GO
GRANT DELETE
    ON OBJECT::[dbo].[ACC_TREE] TO [ap_public]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ACC_TREE] TO [ap_public]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ACC_TREE] TO [ap_public]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ACC_TREE] TO [ap_public]
    AS [dbo];

