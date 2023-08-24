CREATE TABLE [dbo].[SYS_LOGDOC] (
    [LOGID]    INT           IDENTITY (1, 1) NOT NULL,
    [LOG_DATE] DATETIME      CONSTRAINT [DF_SYS_LOGDOC_LOG_DATE] DEFAULT (getdate()) NOT NULL,
    [UID]      NVARCHAR (50) CONSTRAINT [DF_SYS_LOGDOC_UID] DEFAULT (user_id()) NOT NULL,
    [ITEM]     INT           NOT NULL,
    [DOC_ID]   INT           NULL,
    [J_ID]     INT           NULL,
    [FLAGS]    INT           NULL,
    [PRM1]     INT           NULL,
    [PRM2]     INT           NULL,
    [PRM3]     INT           NULL,
    CONSTRAINT [PK_SYS_LOGDOC] PRIMARY KEY CLUSTERED ([LOGID] ASC)
);

