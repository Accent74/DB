-----------------------------------------
create procedure ap_trans_setdone
@id int
as
set nocount on

declare @done smallint
declare @mcid int

select @done = DOC_DONE from DOCUMENTS where DOC_ID=@id
select @mcid = MC_ID from DOCUMENTS where DOC_ID=@id
update JOURNAL set J_DONE=@done, MC_ID=@mcid where DOC_ID=@id


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_trans_setdone] TO [ap_public]
    AS [dbo];

