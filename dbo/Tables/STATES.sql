CREATE TABLE [dbo].[STATES] (
    [ST_ID]    INT           IDENTITY (1, 1) NOT NULL,
    [ST_NAME]  NVARCHAR (50) NOT NULL,
    [ST_TAG]   NVARCHAR (50) NULL,
    [ST_FLAGS] INT           NULL,
    [ST_NO]    INT           NULL,
    CONSTRAINT [PK_STATES] PRIMARY KEY CLUSTERED ([ST_ID] ASC)
);


GO
-----------------------------------------
create trigger STATES_Dtrig on STATES
for delete as

-- cascade deletes from STATE_FLAGS
delete STATE_FLAGS from deleted inner join STATE_FLAGS ON deleted.ST_ID = STATE_FLAGS.ST_ID
-- cascade deletes from STATE_WALK
delete STATE_WALK from deleted inner join STATE_WALK ON deleted.ST_ID = STATE_WALK.ST_FROM
delete STATE_WALK from deleted inner join STATE_WALK ON deleted.ST_ID = STATE_WALK.ST_TO

