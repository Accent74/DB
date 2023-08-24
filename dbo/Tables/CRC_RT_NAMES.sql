CREATE TABLE [dbo].[CRC_RT_NAMES] (
    [RT_ID]      INT            IDENTITY (1, 1) NOT NULL,
    [RT_FLAGS]   INT            NULL,
    [RT_PROGID]  NVARCHAR (50)  NULL,
    [RT_NAME]    NVARCHAR (50)  NULL,
    [RT_MEMO]    NVARCHAR (255) NULL,
    [RT_FORMULA] NVARCHAR (255) NULL,
    CONSTRAINT [PK_CRC_RT_NAMES] PRIMARY KEY NONCLUSTERED ([RT_ID] ASC)
);


GO
---------------------------------------------------------------------
create trigger crcrtnames_DTrig ON CRC_RT_NAMES
for delete
as
-- cascade deletes from CRC_RATES
delete CRC_RATES from deleted inner join CRC_RATES ON deleted.RT_ID = CRC_RATES.RT_ID

