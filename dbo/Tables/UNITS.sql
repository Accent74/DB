CREATE TABLE [dbo].[UNITS] (
    [UN_ID]    INT              IDENTITY (1, 1) NOT NULL,
    [UN_GUID]  UNIQUEIDENTIFIER CONSTRAINT [DF_UNITS_UN_GUID] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [UN_SHORT] NVARCHAR (16)    NOT NULL,
    [UN_NAME]  NVARCHAR (50)    NULL,
    [UN_MEMO]  NVARCHAR (255)   NULL,
    [UN_TAG]   NVARCHAR (50)    NULL,
    CONSTRAINT [PK_UNITS] PRIMARY KEY NONCLUSTERED ([UN_ID] ASC),
    CONSTRAINT [IX_UNITS_GUID] UNIQUE NONCLUSTERED ([UN_GUID] ASC)
);


GO
-----------------------------------------
create trigger units_DTrig on UNITS
for delete 
as
-- cascade deletes from ENT_UNITS
delete ENT_UNITS from deleted inner join ENT_UNITS ON deleted.UN_ID = ENT_UNITS.ENT_ID
-- update PRC_NAMES with this UNIT
update PRC_NAMES set PRC_NAMES.UN_ID=null where PRC_NAMES.UN_ID in (select deleted.UN_ID from deleted)

