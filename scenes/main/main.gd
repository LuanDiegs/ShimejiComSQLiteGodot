extends Control
class_name Main

var ENTITIES = Entities.new()

@onready var criar = %criarButton
@onready var nomeInput = %nomeInput
@onready var label_erro = %labelErro
@onready var container_notifications = $deatShimejiNotifications/containerNotifications

const SHIMEJI = preload("res://scenes/shimeji/shimeji.tscn")

func _ready():
	db.createTable(ENTITIES.tableNames.jogadores, ENTITIES.jogadores)
	insertShimejis()
	
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT, true)
	#get_viewport().transparent_bg = true
	
	criar.connect("button_down", _on_button_criar_clicked)

func _process(delta):
	pass

func _on_button_criar_clicked():
	if(!nomeInput.text):
		label_erro.text = "Insira um nome por gentileza"
		return
	else:
		insertShimeji()
		
func insertShimejis():
	var data = db.get20FirstShimeji()
	
	if(data is String):
		return
		
	for i in data.size():
		var shimeji = SHIMEJI.instantiate() as Shimeji
		shimeji.nameShimeji = data[i]
		add_child(shimeji)


func displayMessage(message: String):
	var toast: DeathShimejiToast  = preload("res://scenes/nodes/deathShimejiToast/death_shimeji_toast.tscn").instantiate() as DeathShimejiToast
	toast.message = message
	container_notifications.add_child(toast)


func insertShimeji(nameShimeji: String = "", isInsertedByTwitch: bool = false):
	var name = nomeInput.text if !nameShimeji else nameShimeji
	var shimeji = SHIMEJI.instantiate() as Shimeji
	
	if(shimeji.createShimeji(name)):
		if(!isInsertedByTwitch):
			label_erro.text = "O registro foi inserido corretamente!"
			label_erro.add_theme_color_override("font_color", Color.DARK_GREEN)
			nomeInput.text = ""
		
		var shimejisInScene = get_tree().get_nodes_in_group("shimeji")
		if(shimejisInScene.size() >= 10):
			var shimejiToKill = randi_range(0, shimejisInScene.size() - 1)
			shimejisInScene[shimejiToKill].shimejiDeath()
			displayMessage("Oh não, parece que o " + str(shimejisInScene[shimejiToKill].nameShimeji) + " foi obliterado! :(")
			
		add_child(shimeji)
	else:
		if(!isInsertedByTwitch):
			label_erro.text = "Houve um erro ao salvar o registro :("
			nomeInput.text = ""

func existShimejiInScene(nameShimeji: String):
	var shimejisInScene = get_tree().get_nodes_in_group("shimeji")
	var findedShimeji = false
	for shimeji: Shimeji in shimejisInScene:
		if shimeji.nameShimeji.to_lower() == nameShimeji.to_lower():
			findedShimeji = true
	return findedShimeji
