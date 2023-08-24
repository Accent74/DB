CREATE RULE [dbo].[ar_param_type]
    AS @value = 3 or (@value >=5 and @value <=8) or @value = 11;


GO
EXECUTE sp_bindrule @rulename = N'[dbo].[ar_param_type]', @objname = N'[dbo].[SER_PARAM_NAMES].[PRM_TYPE]';


GO
EXECUTE sp_bindrule @rulename = N'[dbo].[ar_param_type]', @objname = N'[dbo].[FRM_PARAM_NAMES].[PRM_TYPE]';


GO
EXECUTE sp_bindrule @rulename = N'[dbo].[ar_param_type]', @objname = N'[dbo].[AG_FACT_NAMES].[FA_TYPE]';


GO
EXECUTE sp_bindrule @rulename = N'[dbo].[ar_param_type]', @objname = N'[dbo].[ENT_FACT_NAMES].[FA_TYPE]';


GO
EXECUTE sp_bindrule @rulename = N'[dbo].[ar_param_type]', @objname = N'[dbo].[MISC_FACT_NAMES].[FA_TYPE]';


GO
EXECUTE sp_bindrule @rulename = N'[dbo].[ar_param_type]', @objname = N'[dbo].[DB_FACT_NAMES].[FA_TYPE]';


GO
EXECUTE sp_bindrule @rulename = N'[dbo].[ar_param_type]', @objname = N'[dbo].[RCP_PARAM_NAMES].[PRM_TYPE]';


GO
EXECUTE sp_bindrule @rulename = N'[dbo].[ar_param_type]', @objname = N'[dbo].[RPE_PARAM_NAMES].[PRM_TYPE]';


GO
EXECUTE sp_bindrule @rulename = N'[dbo].[ar_param_type]', @objname = N'[dbo].[ACC_PARAM_NAMES].[PRM_TYPE]';


GO
EXECUTE sp_bindrule @rulename = N'[dbo].[ar_param_type]', @objname = N'[dbo].[AG_PARAM_NAMES].[PRM_TYPE]';


GO
EXECUTE sp_bindrule @rulename = N'[dbo].[ar_param_type]', @objname = N'[dbo].[BIND_PARAM_NAMES].[PRM_TYPE]';


GO
EXECUTE sp_bindrule @rulename = N'[dbo].[ar_param_type]', @objname = N'[dbo].[DB_PARAM_NAMES].[PRM_TYPE]';


GO
EXECUTE sp_bindrule @rulename = N'[dbo].[ar_param_type]', @objname = N'[dbo].[DOC_PARAM_NAMES].[PRM_TYPE]';


GO
EXECUTE sp_bindrule @rulename = N'[dbo].[ar_param_type]', @objname = N'[dbo].[ENT_PARAM_NAMES].[PRM_TYPE]';


GO
EXECUTE sp_bindrule @rulename = N'[dbo].[ar_param_type]', @objname = N'[dbo].[FLD_PARAM_NAMES].[PRM_TYPE]';


GO
EXECUTE sp_bindrule @rulename = N'[dbo].[ar_param_type]', @objname = N'[dbo].[JRN_PARAM_NAMES].[PRM_TYPE]';


GO
EXECUTE sp_bindrule @rulename = N'[dbo].[ar_param_type]', @objname = N'[dbo].[MISC_PARAM_NAMES].[PRM_TYPE]';


GO
EXECUTE sp_bindrule @rulename = N'[dbo].[ar_param_type]', @objname = N'[dbo].[TML_PARAM_NAMES].[PRM_TYPE]';

