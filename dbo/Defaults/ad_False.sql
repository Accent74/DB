CREATE DEFAULT [dbo].[ad_False]
    AS 0;


GO
EXECUTE sp_bindefault @defname = N'[dbo].[ad_False]', @objname = N'[dbo].[TML_TREE].[SHORTCUT]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[ad_False]', @objname = N'[dbo].[ACC_TREE].[SHORTCUT]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[ad_False]', @objname = N'[dbo].[AG_TREE].[SHORTCUT]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[ad_False]', @objname = N'[dbo].[BIND_TREE].[SHORTCUT]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[ad_False]', @objname = N'[dbo].[MISC_TREE].[SHORTCUT]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[ad_False]', @objname = N'[dbo].[FLD_TREE].[SHORTCUT]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[ad_False]', @objname = N'[dbo].[ENT_TREE].[SHORTCUT]';

