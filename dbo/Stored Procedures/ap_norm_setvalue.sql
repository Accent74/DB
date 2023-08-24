-----------------------------------------
create procedure ap_norm_setvalue
@id int,
@x int,
@y int,
@val float = null
as
set nocount on
delete from NORM_VALUES where NRM_ID=@id and NRM_X=@x and NRM_Y=@y
if @val is not null
  insert into NORM_VALUES (NRM_ID, NRM_X, NRM_Y, NRM_DBL) values (@id, @x, @y, @val)  

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_norm_setvalue] TO [ap_public]
    AS [dbo];

