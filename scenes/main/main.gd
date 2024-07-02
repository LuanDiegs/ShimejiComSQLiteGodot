extends Control
class_name main

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
	
	var jogador = Jogador.new(nomeInput.text)
	if(jogador.createJogador()):
		label_erro.text = "O registro foi inserido corretamente!"
		label_erro.add_theme_color_override("font_color", Color.DARK_GREEN)
		nomeInput.text = ""
		
		var shimejisInScene = get_tree().get_nodes_in_group("shimeji")
		if(shimejisInScene.size() == 10):
			var shimejiToKill = randi_range(0, shimejisInScene.size() - 1)
			shimejisInScene[shimejiToKill].shimejiDeath()
			displayMessage("Oh não, parece que o " + str(shimejisInScene[shimejiToKill].nameShimeji) + " foi obliterado! :(")
		
		var shimeji = SHIMEJI.instantiate()
		add_child(shimeji)
		
	else:
		label_erro.text = "Houve um erro ao salvar o registro :("
		nomeInput.text = ""
		
		
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
