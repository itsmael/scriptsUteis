/* SELECT MASTER DB TO EXECUTE THIS SCRIPT*/
use master
go
/*DECLARE VARIABLES*/
declare @dbnames nvarchar(max)
declare @statement nvarchar(max)
declare @date nvarchar(max)

/* SET THE VALOR OF THE DATE */
set @date= '10/10/2019'

set @dbnames = ''
set @statement = ''

/* SELECTING DATABASES NAMES AND SAVING IN THE DBNAMES VAR */
select @dbnames = @dbnames + ',[' + name + ']' from sys.databases 
    where name 
    NOT IN ('master','model','msdb','tempdb') 
	AND create_date < @date

if len(@dbnames) = 0
    begin
    print 'Não há bancos para serem deletados antes de ' + @date
    end
else
    begin
    set @statement = 'drop database ' + substring(@dbnames, 2, len(@dbnames))
    print @statement
    exec sp_executesql @statement
    end
go


