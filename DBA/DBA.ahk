/*
	DataBase NameSpace Import
*/

#Include Base.ahk
#Include Collection.ahk

;drivers
#Include SQLite_L.ahk
#Include mySQL.ahk
#Include ADO.ahk

class DBA ; namespace DBA
{
	#Include DataBaseFactory.ahk
	#Include DataBaseAbstract.ahk
	

	; Concrete SQL Providers
	#Include DataBaseSQLLite.ahk
	#Include DataBaseMySQL.ahk
	#Include DataBaseADO.ahk
	
	#Include RecordSetSqlLite.ahk
	#Include RecordSetADO.ahk
	#Include RecordSetMySQL.ahk
}