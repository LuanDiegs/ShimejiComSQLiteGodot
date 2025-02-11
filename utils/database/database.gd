extends Node
class_name Database

var database: SQLite = SQLite.new()

func _init():
	connectDatabase()


func connectDatabase():
	database.path = "res://shimeji.db"
	database.open_db()
	
	
func createTable(tableName: String, newTable: Dictionary):
	database.create_table(tableName, newTable)


func insertData(tableName: String, data: Dictionary):
	return database.insert_row(tableName, data)


func tableExists(tableName: String):
	database.query("SELECT name FROM sqlite_master WHERE type='table' AND name='"+tableName+"'")
	
	if(database.query_result.size() > 0):
		return true
		
	return false

func getLastName():
	database.query("SELECT nome FROM jogadores ORDER BY ID DESC LIMIT 1")
	
	if(database.query_result.size() == 0):
		return "erro"
		
	return str(database.query_result[0].nome)

func get20FirstShimeji():
	var nameList: Array[String]
	database.query("SELECT nome FROM jogadores ORDER BY ID DESC LIMIT 10")
	
	if(database.query_result.size() == 0):
		return "No data in the database"
	
	for i in database.query_result.size():
		nameList.append(database.query_result[i].nome)
			
	return nameList
