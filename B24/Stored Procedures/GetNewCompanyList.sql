create   procedure b24.GetNewCompanyList
as
begin
   declare @prmid int = 
      (
         select prm_id 
         from AG_PARAM_NAMES
         where 
            PRM_NAME like 'Битрикс ID' 
            and NODE_TYPE = 1
      )

   -- выбрать всех новых, которые нужно экспортировать в битрикс
   select 
      [AgID] = a.ag_id
      ,[AgName] = a.ag_name
      ,[AgAddress] = isnull(a.ag_address, '')
      ,[AgContact] = isnull(a.AG_CONTACT, '')
      ,[AgPhones] = isnull(a.ag_phone, '')
      ,[AgEMails] = isnull(a.AG_EMAIL, '')
   from AGENTS as a
   inner join ag_tree on 
      id = ag_id
      and SHORTCUT = 0
   left join agents as p on p.ag_id = p0
   left join AG_PARAMS as ap on 
      ap.AG_ID = a.AG_ID 
      and prm_id = @prmid
   where 
      a.ag_type = 1                 -- предприятия
      and PRM_LONG is null          -- не созданные в битриксе
      and isnull(p.AG_TYPE, 0) = 0  -- родитель папка
end
