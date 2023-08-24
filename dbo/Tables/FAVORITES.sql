CREATE TABLE [dbo].[FAVORITES] (
    [F_ID]     INT            IDENTITY (1, 1) NOT NULL,
    [F_KIND]   INT            NOT NULL,
    [F_TYPE]   INT            NULL,
    [F_PARENT] INT            NULL,
    [F_REF]    INT            NULL,
    [F_NAME]   NVARCHAR (255) NULL,
    CONSTRAINT [PK_FAVORITES] PRIMARY KEY CLUSTERED ([F_ID] ASC)
);

