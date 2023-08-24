----------------------------------------
create procedure ap_log_size
as
declare @ret int
select @ret = count(*) from SYS_LOG
return @ret


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ap_log_size] TO [ap_public]
    AS [dbo];

