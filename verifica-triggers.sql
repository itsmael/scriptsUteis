SELECT
   sysobjects.name AS trigger_name
  ,OBJECT_NAME(parent_obj) AS table_name
  ,OBJECTPROPERTY(id, 'ExecIsTriggerDisabled') AS [disabled]
FROM sysobjects
INNER JOIN sys.tables t
  ON sysobjects.parent_obj = t.object_id    
INNER JOIN sys.schemas s
  ON t.schema_id = s.schema_id
WHERE sysobjects.type = 'TR' and OBJECTPROPERTY(id, 'ExecIsTriggerDisabled') = 1