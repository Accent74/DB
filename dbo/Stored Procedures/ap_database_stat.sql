
---------------------------------------------------------------------
-- Статистика по базе данных
---------------------------------------------------------------------
create procedure ap_database_stat
as
select (select count(*) from DOCUMENTS) as doccount,
       (select count(*) from JOURNAL) as jrncount,
       (select count(*) from AGENTS) as agcount,
       (select count(*) from ENTITIES) as entcount,
       (select count(*) from MISC) as misccount



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_database_stat] TO [ap_public]
    AS [dbo];

