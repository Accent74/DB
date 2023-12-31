﻿CREATE TABLE [dbo].[ACC_CORR] (
    [AC_PK]   INT            IDENTITY (1, 1) NOT NULL,
    [ACC_DB]  INT            NOT NULL,
    [ACC_CR]  INT            NOT NULL,
    [AC_MEMO] NVARCHAR (255) NULL,
    CONSTRAINT [PK_ACC_CORR] PRIMARY KEY NONCLUSTERED ([AC_PK] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_ACC_CORR_DB]
    ON [dbo].[ACC_CORR]([ACC_DB] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ACC_CORR_CR]
    ON [dbo].[ACC_CORR]([ACC_CR] ASC);

