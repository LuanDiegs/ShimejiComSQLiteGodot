extends Node
class_name TwitchContainer

@onready var canal_input = $HContainerTwitch/VContainerTwitch/canalInput
@onready var conectar_button = $HContainerTwitch/VContainerTwitch/conectarButton
@onready var label_erro = $HContainerTwitch/VContainerTwitch/labelErro

func _ready():
	conectar_button.connect("pressed", startGettingMessagesTwitch)


func startGettingMessagesTwitch():
	connectToChannel()
	
	
func getMessage(chatter: Chatter):	
	print("Message received from %s: %s" % [chatter.tags.display_name, chatter.message])
	
	var main: Main = get_parent() 
	if(chatter.message == "!s" and !main.existShimejiInScene(chatter.tags.display_name)):
		main.insertShimeji(chatter.tags.display_name, true)
	
	
func connectToChannel():
	var channelName: String = canal_input.text
	
	if !channelName:
		label_erro.text = "Insira um canal por gentileza"
		label_erro.add_theme_color_override("font_color", Color.FIREBRICK)
		
	if !VerySimpleTwitch._twitch_chat or VerySimpleTwitch._twitch_chat._channel.login != channelName:
		var oldChannelName = VerySimpleTwitch._twitch_chat._channel.login if VerySimpleTwitch._twitch_chat else null
		VerySimpleTwitch.login_chat_anon(channelName)
		
		if !VerySimpleTwitch._twitch_chat._hasConnected:
			VerySimpleTwitch.chat_message_received.connect(getMessage)

		if oldChannelName and oldChannelName != channelName:
			VerySimpleTwitch.change_Channel()

		label_erro.text = "Conectado com sucesso ao canal " + str(VerySimpleTwitch._twitch_chat._channel.login) 
		label_erro.add_theme_color_override("font_color", Color.SEA_GREEN)		
	else:
		label_erro.text = "O canal já está vinculado!"
