CREATE DEFAULT [dbo].[ad_defNum]
    AS 1;


GO
EXECUTE sp_bindefault @defname = N'[dbo].[ad_defNum]', @objname = N'[dbo].[ENT_UNITS].[EU_NUM]';

