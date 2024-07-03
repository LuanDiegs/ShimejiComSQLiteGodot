extends CharacterBody2D
class_name Shimeji
	

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var nome = $Entidade/Nome
@onready var timer_change_state = $TimerChangeState
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animations = $Animations
@onready var state: State = $State

const VELOCITY = 300;
const JUMP_VELOCITY = -400

var nameShimeji: String

func _ready():
	global_position.y = -100
	global_position.x = randi_range(0, get_viewport().size.x)
	
	insertNameOnShimeji()
	timer_change_state.connect("timeout", randomizeState)
	
	
func _physics_process(delta):
	gravityShimeji(delta)
	move_and_slide()


func insertNameOnShimeji():
	var newNameShimeji = nameShimeji
	if(!newNameShimeji):
		newNameShimeji = db.getLastName()
		nameShimeji = newNameShimeji
		
	nome.text = newNameShimeji


func gravityShimeji(delta):
	if global_position.y <= get_viewport().size.y:
		velocity.y += gravity * delta
	
	if global_position.y > get_viewport().size.y:
		global_position.y = get_viewport().size.y
		velocity.y = 0


func randomizeState():
	var randomState = state.randomizeState()
	state.changeState(randomState)
	
	
func shimejiDeath():
	self.z_index = 100
	velocity = Vector2(0, 0)
	animations.play("death")


func createShimeji(name: String):
	var shimeji = Jogador.new(name)
	
	if(shimeji.createJogador()):
		return true
		
	return false
