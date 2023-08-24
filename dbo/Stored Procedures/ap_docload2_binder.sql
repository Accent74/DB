----------------------------------------
create procedure ap_docload2_binder
@id Int,
@sd datetime,
@ed datetime,
@mcid int
as
set nocount on
declare @tp int
select @tp = BIND_TYPE from BINDERS where BIND_ID=@tp
if @tp = 0
  select null where 1<>1
else
  select distinct DOCUMENTS.DOC_ID, DOCUMENTS.DOC_DONE,DOCUMENTS.DOC_DATE, 
    DOCUMENTS.DOC_NAME, DOCUMENTS.DOC_MEMO, DOCUMENTS.DOC_NO,
    DOCUMENTS.FRM_ID, DOCUMENTS.DOC_SUM,DOCUMENTS.ST_ID,
    DOCUMENTS.DOC_TAG, DOCUMENTS.DOC_LINK, DOCUMENTS.TML_ID, 
    DOCUMENTS.DOC_PS1, DOCUMENTS.DOC_PS2, DOCUMENTS.DOC_PS3, 
    DOCUMENTS.DOC_PL1, DOCUMENTS.DOC_PL2, DOCUMENTS.DOC_PL3, 
    DOCUMENTS.DOC_PD1, DOCUMENTS.DOC_PD2, DOCUMENTS.DOC_PD3, 
    DOCUMENTS.DOC_PC1, DOCUMENTS.DOC_PC2, DOCUMENTS.DOC_PC3, 
    case when exists(select * from BIND_DOCS as T where DOCUMENTS.DOC_ID=T.DOC_ID) then 1 else 0 end, 
    DOCUMENTS.FLD_ID, DOCUMENTS.DOC_XSTATUS
  from DOCUMENTS inner join BIND_DOCS on DOCUMENTS.DOC_ID = BIND_DOCS.DOC_ID
  where BIND_DOCS.BIND_ID=@id and DOCUMENTS.MC_ID=@mcid and DOCUMENTS.DOC_DONE < 100 and
    DOCUMENTS.DOC_DATE>=@sd and DOCUMENTS.DOC_DATE<@ed

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_docload2_binder] TO [ap_public]
    AS [dbo];

