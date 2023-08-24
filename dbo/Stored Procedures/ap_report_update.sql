--------------------------------------------
create procedure ap_report_update
@id int,
@name nvarchar(256),
@memo nvarchar(256),
@type smallint,
@x smallint,
@xid int,
@s1 nvarchar(256) = null,
@s2 nvarchar(256) = null,
@s3 nvarchar(256) = null,
@s4 nvarchar(256) = null,
@s5 nvarchar(256) = null,
@s6 nvarchar(256) = null,
@l1 int = null,
@l2 int = null,
@l3 int = null,
@l4 int = null,
@l5 int = null
as
set nocount on
declare @res int
begin tran
if @id = 0
  begin
    insert into REPORTS 
      (REP_NAME,REP_MEMO,REP_TYPE,REP_X,REP_X_ID,
       REP_PS1,REP_PS2,REP_PS3,REP_PS4,REP_PS5,REP_PS6,
       REP_PL1,REP_PL2,REP_PL3,REP_PL4,REP_PL5) 
    values
      (@name,@memo,@type,@x,@xid,@s1,@s2,@s3,@s4,@s5,@s6,@l1,@l2,@l3,@l4,@l5)
    select @res = ident_current('REPORTS')
  end
else 
  begin
    update REPORTS
    set REP_NAME=@name,REP_MEMO=@memo,REP_TYPE=@type,REP_X=@x, REP_X_ID=@xid,
        REP_PS1=@s1, REP_PS2=@s2, REP_PS3=@s3, REP_PS4=@s4, REP_PS5=@s5, REP_PS6=@s6,
        REP_PL1=@l1, REP_PL2=@l2, REP_PL3=@l3, REP_PL4=@l4, REP_PL5=@l5
    where 
      REP_ID=@id
    select @res = @id
  end
commit tran
return @res

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_report_update] TO [ap_public]
    AS [dbo];

