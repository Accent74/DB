-----------------------------------------
create procedure ap_norm_values
@id int = 0
as
set nocount on
  select NRM_X, NRM_Y, NRM_DBL from NORM_VALUES
  where NRM_ID=@id

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_norm_values] TO [ap_public]
    AS [dbo];

