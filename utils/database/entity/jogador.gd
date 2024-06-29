class_name Jogador

var entities: Entities = Entities.new()

var tableName = entities.tableNames.jogadores
var Nome: String

func createJogador():
	var data = {
		"nome": Nome
	}
	
	return db.insertData(entities.tableNames.jogadores, data)
	
func _init(nome: String, database: Database = null):
	self.Nome = nome
