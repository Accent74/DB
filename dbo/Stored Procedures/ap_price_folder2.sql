﻿-----------------------------------------
create procedure ap_price_folder2
@dt datetime,
@prl int,
@fld int
as
set nocount on

select 
  PRC_CONTENTS.ENT_ID as ENT_ID, PRC_CONTENTS.PRC_ID AS PRC_ID, 
  PRC_CONTENTS.PRL_ID as PRL_ID,
  Max(PRC_CONTENTS.PRC_DATE) AS PRC_DATE
into #tmpent 
from PRC_CONTENTS
where 
  PRC_CONTENTS.PRC_DATE<=@dt and
  PRC_CONTENTS.PRL_ID = @prl and 
  PRC_CONTENTS.PRC_ID in (select X.PRC_ID from PRL_PRICES as X where X.PRL_ID=@prl)
group by 
  PRC_CONTENTS.ENT_ID, PRC_CONTENTS.PRC_ID, PRC_CONTENTS.PRL_ID;


select 
  ENT_TREE.P0, PRC_CONTENTS.PRC_ID, PRC_CONTENTS.ENT_ID, 
  PRC_CONTENTS.PRC_VALUE
from 
  (PRC_CONTENTS inner join #tmpent on 
  (PRC_CONTENTS.PRC_ID=#tmpent.PRC_ID) and 
  (PRC_CONTENTS.PRL_ID=#tmpent.PRL_ID) and
  (PRC_CONTENTS.ENT_ID=#tmpent.ENT_ID) and 
  (PRC_CONTENTS.PRC_DATE = #tmpent.PRC_DATE)) 
  inner join ENT_TREE ON ENT_TREE.ID=PRC_CONTENTS.ENT_ID
where
  (ENT_TREE.P0=@fld or P1=@fld or P2=@fld or P3=@fld or P4=@fld or P5=@fld or P6=@fld or P7=@fld)
  and PRC_CONTENTS.PRL_ID=@prl


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_price_folder2] TO [ap_public]
    AS [dbo];

