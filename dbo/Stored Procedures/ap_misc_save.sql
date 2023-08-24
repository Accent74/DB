----------------------------------------
create procedure ap_misc_save
@id int,
@name nvarchar(256),
@tag nvarchar(51) = null,
@memo nvarchar(256) = null,
@s1 nvarchar(256) = null,
@s2 nvarchar(256) = null,
@s3 nvarchar(256) = null,
@l1 int = null,
@l2 int = null,
@l3 int = null,
@c1 money = null,
@c2 money = null,
@c3 money = null,
@d1 datetime = null,
@d2 datetime = null,
@d3 datetime = null
as
set nocount on
begin tran
update MISC set 
  MSC_NAME=@name,MSC_TAG=@tag,MSC_MEMO=@memo,
  MSC_STR1=@s1,MSC_STR2=@s2,MSC_STR3=@s3, 
  MSC_LNG1=@l1,MSC_LNG2=@l2,MSC_LNG3=@l3, 
  MSC_CY1=@c1, MSC_CY2=@c2, MSC_CY3=@c3, 
  MSC_DT1=@d1, MSC_DT2=@d2, MSC_DT3=@d3 
where MSC_ID=@id

commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_misc_save] TO [ap_public]
    AS [dbo];

