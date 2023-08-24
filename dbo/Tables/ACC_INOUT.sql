﻿CREATE TABLE [dbo].[ACC_INOUT] (
    [AIO_PK]   INT            IDENTITY (1, 1) NOT NULL,
    [AIO_IN]   INT            NULL,
    [AIO_OUT]  INT            NULL,
    [AIO_MEMO] NVARCHAR (255) NULL,
    CONSTRAINT [PK_ACC_INOUT] PRIMARY KEY CLUSTERED ([AIO_PK] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_ACC_INOUT_IN]
    ON [dbo].[ACC_INOUT]([AIO_IN] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ACC_INOUT_OUT]
    ON [dbo].[ACC_INOUT]([AIO_OUT] ASC);
