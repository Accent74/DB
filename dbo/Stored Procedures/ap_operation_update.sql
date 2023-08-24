----------------------------------------
create procedure ap_operation_update
  @docid int,
  @date datetime,
  @sum  money,
  @name nvarchar(256),
  @memo nvarchar(256),
  @tag nvarchar(51),
  @done smallint,
  @form int,
  @tml int,
  @no nvarchar(256),
  @s1 nvarchar(256),
  @s2 nvarchar(256),
  @s3 nvarchar(256),
  @l1 int,
  @l2 int,
  @l3 int,
  @c1 money,
  @c2 money,
  @c3 money,
  @d1 datetime,
  @d2 datetime,
  @d3 datetime,
  @link int,
  @fld int,
  @nolog int = 0,
  @guid uniqueidentifier = null,
  @st int = 0,
  @changes int = 0,
  @mcid int = 0,
  @xst nchar(3) = null
as
set nocount on

declare @last datetime
declare @id int
declare @fx int
select @fx = @fld
if @fx = 0
  select @fx = null

select @last = getdate()

if @docid = 0
  begin
    if @guid is null 
    begin
    insert into DOCUMENTS 
      (DOC_DATE,DOC_SUM,DOC_NAME,DOC_MEMO,DOC_TAG,DOC_DONE, FRM_ID,
      TML_ID, DOC_NO, DOC_PS1, DOC_PS2, DOC_PS3, DOC_PL1, DOC_PL2, DOC_PL3,
      DOC_PC1, DOC_PC2, DOC_PC3, DOC_PD1, DOC_PD2, DOC_PD3, DOC_LINK, LAST_DATE, ST_ID, MC_ID, FLD_ID, DOC_XSTATUS)
    values
      (@date,@sum,@name,@memo,@tag,@done,@form,@tml,@no,
       @s1,@s2,@s3,@l1,@l2,@l3,@c1,@c2,@c3,@d1,@d2,@d3,@link,@last,@st,@mcid, @fx, @xst)
    select @id = ident_current('DOCUMENTS')
    end
    else
    begin
    insert into DOCUMENTS 
      (DOC_DATE,DOC_SUM,DOC_NAME,DOC_MEMO,DOC_TAG,DOC_DONE, FRM_ID,
      TML_ID, DOC_NO, DOC_PS1, DOC_PS2, DOC_PS3, DOC_PL1, DOC_PL2, DOC_PL3,
      DOC_PC1, DOC_PC2, DOC_PC3, DOC_PD1, DOC_PD2, DOC_PD3, DOC_LINK, LAST_DATE, DOC_GUID, ST_ID, MC_ID, FLD_ID,DOC_XSTATUS)
    values
      (@date,@sum,@name,@memo,@tag,@done,@form,@tml,@no,@s1,@s2,@s3,@l1,@l2,@l3,@c1,@c2,@c3,@d1,@d2,@d3,@link,@last,@guid,@st,@mcid,@fx,@xst)
    select @id = ident_current('DOCUMENTS')
    end
    -- write to log
    if @nolog <> 1
      exec ap_log_add N'D',N'I',@id,@date,@sum
  end
else
  begin
    update DOCUMENTS set
      DOC_DATE=@date,DOC_SUM=@sum,DOC_NAME=@name,DOC_MEMO=@memo,
      DOC_TAG=@tag,DOC_DONE=@done, FRM_ID=@form,TML_ID=@tml, DOC_NO=@no, 
      DOC_PS1=@s1, DOC_PS2=@s2, DOC_PS3=@s3, DOC_PL1=@l1, DOC_PL2=@l2, DOC_PL3=@l3,
      DOC_PC1=@c1, DOC_PC2=@c2, DOC_PC3=@c3, DOC_PD1=@d1, DOC_PD2=@d2, DOC_PD3=@d3, 
      DOC_LINK=@link, LAST_DATE=@last, ST_ID=@st, DOC_XSTATUS=@xst
    where DOC_ID=@docid

    select @id = @docid
    -- write to log
    if @nolog <> 1
    begin
      exec ap_log_add N'D',N'U',@id,@date,@sum
      exec ap_logdoc_add 0,@id,0, @changes
    end
  end
return @id

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_operation_update] TO [ap_public]
    AS [dbo];

