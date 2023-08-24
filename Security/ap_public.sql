CREATE ROLE [ap_public]
    AUTHORIZATION [dbo];


GO
ALTER ROLE [ap_public] ADD MEMBER [_Admin];

