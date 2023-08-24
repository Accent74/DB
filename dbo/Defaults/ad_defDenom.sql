CREATE DEFAULT [dbo].[ad_defDenom]
    AS 1;


GO
EXECUTE sp_bindefault @defname = N'[dbo].[ad_defDenom]', @objname = N'[dbo].[ENT_UNITS].[EU_DENOM]';

