execute sp_msforeachdb '
if db_name() not in (''tempdb'', ''model'',''master'',''msdb'')
    use [?]
          begin
            declare @nm_pasta varchar(100)
            set @nm_pasta = ''C:\PATH\''
            declare @nm_arquivo varchar(1000)
            -- Nome do arquivo: C:\PATH\2021\aaaa-mm-dd__NomeInstancia__NomeBanco.bak
            set @nm_arquivo =
                replace(convert(varchar, getdate(), 102), ''.'', ''-'') + ''__'' +
                replace(@@servername, ''\'', ''-'') + ''__'' +
                replace(db_name(), ''\'', ''-'')
            set @nm_arquivo = @nm_pasta + @nm_arquivo + ''.bak''
            print ''Iniciando o backup: '' + @nm_arquivo
            backup database [?] to disk = @nm_arquivo with init, copy_only
        end
    else
        print ''Backup do banco ? ignorado.''
     '