----------------------------------------
create procedure ap_unit_load
as
set nocount on
select UN_ID, UN_SHORT, UN_NAME, UN_MEMO, UN_TAG, UN_GUID from UNITS

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_unit_load] TO [ap_public]
    AS [dbo];

