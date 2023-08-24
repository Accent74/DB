-----------------------------------------
create procedure ap_misc_createref 
@name nvarchar(255),
@ref smallint,
@refid int
as

set nocount on

begin tran

declare @id int
declare @no int
if @ref = 0 
  select @ref = null
if @refid = 0
  select @refid = null

-- добавим запись в MISC_ATTR    
insert into MISC_ATTR (MSC_VISIBLE) values (0)
select @no = ident_current('MISC_ATTR')

insert into MISC (MSC_NO,MSC_NAME,MSC_TYPE,MSC_REF,MSC_REFID) VALUES (@no, @name,-1, @ref, @refid)
select @id = ident_current('MISC')
insert into MISC_TREE (ID,P0,P1,P2,P3,P4,P5,P6,P7,SHORTCUT) values (@id,0,0,0,0,0,0,0,0,0)

commit 
return @id

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_misc_createref] TO [ap_public]
    AS [dbo];

