execute sp_msforeachdb '
use [?]
if db_name() not in (''tempdb'', ''model'',''master'',''msdb'')
	begin 
		select db_name()
		end
	else
		print ''db_name ignorado''
'