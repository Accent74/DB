CREATE procedure B24.GetCompanyUpdated
as
begin
   declare @dLastUpdate datetime = 
   isnull((
      select top 1 prm_date
      from USR_PARAMS
      where prm_name like 'BitrixLastUpdate'
   ), cast(getdate() as date)
   )

   declare @prmid int = 
   (
      select top 1 prm_id
      from AG_PARAM_NAMES
      where prm_name like 'Битрикс ID'
   ) ;

   drop table if exists #tmp
   select 
      a.ag_id
      ,ag_name
      ,ag_memo = isnull(ag_memo, '')
      ,AG_ADDRESS = isnull(AG_ADDRESS, '')
      ,ag_phone = isnull(ag_phone, '')
      ,ag_email = isnull(ag_email, '')
      ,BitrixID = p.PRM_LONG
      ,AG_LastUpdate
      ,AG_Created
   into #tmp
   from agents as a
   left join AG_PARAMS as p 
      on p.AG_ID = a.ag_id
      and p.PRM_ID = @prmid
   where 
      ag_type = 1
      and AG_LastUpdate > @dLastUpdate

   if @@ROWCOUNT > 0
      update USR_PARAMS
      set prm_date = (select max(ag_LastUpdate) from #tmp)
      where prm_name like 'BitrixLastUpdate'

   select *
   from #tmp
end

