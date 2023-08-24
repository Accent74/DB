----------------------------------------
create procedure ap_agent_nested2
@id int
as
set nocount on
select ID from AG_TREE 
where 
  P0=@id or P1=@id or P2=@id or P3=@id or P4=@id or P5=@id or P6=@id or P7=@id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_agent_nested2] TO [ap_public]
    AS [dbo];

