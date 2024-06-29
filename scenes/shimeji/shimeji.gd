extends CharacterBody2D
class_name Shimeji
	

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var nome = $Entidade/Nome
@onready var timer_action = $TimerAction
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var action = $Action
@export var state: Action.ACTION_ENUM


const VELOCITY = 300;
const JUMP_VELOCITY = -400


var direction: int
var isJumping: bool
var nameShimeji: String

func _ready():
	global_position.y = -200
	global_position.x = randi_range(0, get_viewport().size.x)
	insertNameOnShimeji()
	
	timer_action.connect("timeout", randomizeAction)
	
	
func _physics_process(delta):
	gravityShimeji(delta)
	moveShimeji()
	
	move_and_slide()


func insertNameOnShimeji():
	var newNameShimeji = nameShimeji
	if(!newNameShimeji):
		newNameShimeji = db.getLastName()
		
	nome.text = newNameShimeji


func gravityShimeji(delta):
	if global_position.y <= get_viewport().size.y:
		velocity.y += gravity * delta
	
	if global_position.y >= get_viewport().size.y:
		global_position.y = get_viewport().size.y
		velocity.y = 0


func randomizeAction():
	var newAction = action.randomizeAction()
	
	direction = 1 if randi_range(0, 100) < 50 else -1
	isJumping = !global_position.y >= get_viewport().size.y
	state = newAction


func moveShimeji():
	match state:
		Action.ACTION_ENUM.move:
			if(ray_cast_right.global_position.x >= get_viewport().size.x or ray_cast_left.global_position.x <= 0):
				direction = 1 if direction == -1 else -1
				
			velocity.x = direction * VELOCITY
				
		Action.ACTION_ENUM.idle:
			velocity.x = 0
			
		Action.ACTION_ENUM.jump:
			if(!isJumping):
				isJumping = true
				velocity.y = JUMP_VELOCITY
				velocity.x = 0
			
