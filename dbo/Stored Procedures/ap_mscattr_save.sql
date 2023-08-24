----------------------------------------
create procedure ap_mscattr_save
@no int,
@vis int = 0,
@s1 nvarchar(51) = null,
@s2 nvarchar(51) = null,
@s3 nvarchar(51) = null,
@l1 nvarchar(51) = null,
@l2 nvarchar(51) = null,
@l3 nvarchar(51) = null,
@t1 int = null,
@t2 int = null,
@t3 int = null,
@c1 nvarchar(51) = null,
@c2 nvarchar(51) = null,
@c3 nvarchar(51) = null,
@d1 nvarchar(51) = null,
@d2 nvarchar(51) = null,
@d3 nvarchar(51) = null,
@reset int = 0,
@flags int = 0
as
set nocount on
begin tran
update MISC_ATTR set
  MSC_VISIBLE=@vis,MS1_NAME=@s1, MS2_NAME=@s2, MS3_NAME=@s3,
  ML1_NAME=@l1, ML2_NAME=@l2, ML3_NAME=@l3, ML1_TYPE=@t1, ML2_TYPE=@t2, ML3_TYPE=@t3,
  MC1_NAME=@c1, MC2_NAME=@c2, MC3_NAME=@c3, MD1_NAME=@d1, MD2_NAME=@d2, MD3_NAME=@d3,
  MSC_FLAGS=@flags
where MSC_NO=@no
if @reset & 0x00000001 <> 0
  begin
     -- сбросить значения LONG1
     update MISC set MSC_LNG1 = null where MSC_NO=@no
  end
if @reset & 0x00000002 <> 0
  begin
     -- сбросить значения LONG2
     update MISC set MSC_LNG2 = null where MSC_NO=@no
  end
if @reset & 0x00000004 <> 0
  begin
     -- сбросить значения LONG3
     update MISC set MSC_LNG3 = null where MSC_NO=@no
  end
commit tran


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_mscattr_save] TO [ap_public]
    AS [dbo];

