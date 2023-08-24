----------------------------------------
create procedure ap_docload2_misc
@id int,
@sd datetime,
@ed datetime,
@mcid int
as
set nocount on
declare @no int
declare @tp int
select @no = MSC_NO, @tp=MSC_TYPE from MISC where MSC_ID=@id
if @tp = -1
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
  from (DOCUMENTS inner join JOURNAL on DOCUMENTS.DOC_ID=JOURNAL.DOC_ID) 
        inner join JRN_MISC on JOURNAL.J_ID = JRN_MISC.J_ID
  where JRN_MISC.MSC_ID=@id and JRN_MISC.MSC_NO=@no and DOCUMENTS.MC_ID=@mcid and DOCUMENTS.DOC_DONE < 100 and
    DOCUMENTS.DOC_DATE>=@sd and DOCUMENTS.DOC_DATE<@ed

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_docload2_misc] TO [ap_public]
    AS [dbo];

