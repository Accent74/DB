-----------------------------------------------------------
create procedure ap_trans_delete7 
@p1 int = null,
@p2 int = null,
@p3 int = null,
@p4 int = null,
@p5 int = null,
@p6 int = null,
@p7 int = null
as
set nocount on
delete from JOURNAL 
where J_ID=@p1 or J_ID=@p2 or J_ID=@p3 or 
      J_ID=@p4 or J_ID=@p5 or J_ID=@p6 or J_ID=@p7



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_trans_delete7] TO [ap_public]
    AS [dbo];

