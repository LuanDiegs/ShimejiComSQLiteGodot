extends CharacterBody2D
class_name Shimeji
	
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var nome = $Nome

func _ready():
	global_position.y = -200
	global_position.x = get_viewport().size.x / 2
	insertNameOnShimeji()
	
func _physics_process(delta):
	if global_position.y <= get_viewport().size.y:
		velocity.y += gravity * delta
	
	if global_position.y >= get_viewport().size.y:
		velocity.y = 0
		global_position.y = get_viewport().size.y
	
	move_and_slide()

func insertNameOnShimeji():
	var name = db.getLastName()
	nome.text = name
