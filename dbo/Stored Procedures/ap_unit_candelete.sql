----------------------------------------
create procedure ap_unit_candelete
@id int
as
set nocount on
if exists(select * from JOURNAL where J_UN=@id or JF_UN=@id)
begin
   raiserror (N'Нельзя удалить едининцу измерения поскольку\nесть операции, в которых она используется',16,-1)
   return 1
end

if exists(select * from ENTITIES where UN_ID=@id)
begin
   raiserror (N'Нельзя удалить едининцу измерения поскольку есть\nобъекты учета, для которых она установлена по умолчанию',16,-1)
   return 2
end
return 0


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_unit_candelete] TO [ap_public]
    AS [dbo];

