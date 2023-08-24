------------------------------------------------------
create procedure ap_account_hassub 
@id int
as
set nocount on

declare @rv int

select @rv = count(*) from ACC_TREE 
where SHORTCUT=0 and 
(P0=@id or P1=@id or P2=@id or P3=@id or P4=@id or P5=@id or P6=@id or P7=@id)

return @rv


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_account_hassub] TO [ap_public]
    AS [dbo];

