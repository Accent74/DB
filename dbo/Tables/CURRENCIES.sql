CREATE TABLE [dbo].[CURRENCIES] (
    [CRC_ID]     INT              IDENTITY (1, 1) NOT NULL,
    [CRC_GUID]   UNIQUEIDENTIFIER CONSTRAINT [DF_CURRENCIES_CRC_GUID] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [CRC_NAME]   NVARCHAR (255)   NULL,
    [CRC_CODE]   NVARCHAR (3)     NULL,
    [CRC_SHORT]  NVARCHAR (8)     NOT NULL,
    [CRC_SPELL]  NVARCHAR (255)   NULL,
    [CRC_DENOM]  INT              NOT NULL,
    [CRC_FORMAT] INT              NULL,
    [CRC_FLAGS]  INT              NULL,
    CONSTRAINT [PK_CURRENCIES] PRIMARY KEY NONCLUSTERED ([CRC_ID] ASC)
);


GO
---------------------------------------------------------------------
create trigger currencies_DTrig ON CURRENCIES
for delete 
as
-- cascade deletes from JRN_CRC
delete JRN_CRC from deleted inner join JRN_CRC ON deleted.CRC_ID = JRN_CRC.CRC_ID
-- cascade deletes from CRC_RATES
delete CRC_RATES from deleted inner join CRC_RATES ON deleted.CRC_ID = CRC_RATES.CRC_ID

