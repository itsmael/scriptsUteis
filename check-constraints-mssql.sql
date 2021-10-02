SELECT
KCU1.CONSTRAINT_NAME AS 'FK_Nome_Constraint'
, KCU1.TABLE_NAME AS 'FK_Nome_Tabela'
, KCU1.COLUMN_NAME AS 'FK_Nome_Coluna'
, FK.is_disabled AS 'FK_Esta_Desativada'
, KCU2.CONSTRAINT_NAME AS 'PK_Nome_Constraint_Referenciada'
, KCU2.TABLE_NAME AS 'PK_Nome_Tabela_Referenciada'
, KCU2.COLUMN_NAME AS 'PK_Nome_Coluna_Referenciada'
FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS RC
JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE KCU1
ON KCU1.CONSTRAINT_CATALOG = RC.CONSTRAINT_CATALOG
AND KCU1.CONSTRAINT_SCHEMA = RC.CONSTRAINT_SCHEMA
AND KCU1.CONSTRAINT_NAME = RC.CONSTRAINT_NAME
JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE KCU2
ON KCU2.CONSTRAINT_CATALOG = RC.UNIQUE_CONSTRAINT_CATALOG
AND KCU2.CONSTRAINT_SCHEMA = RC.UNIQUE_CONSTRAINT_SCHEMA
AND KCU2.CONSTRAINT_NAME = RC.UNIQUE_CONSTRAINT_NAME
AND KCU2.ORDINAL_POSITION = KCU1.ORDINAL_POSITION
JOIN sys.foreign_keys FK on FK.name = KCU1.CONSTRAINT_NAME
where
FK.is_disabled = 1

Order by
KCU1.TABLE_NAME