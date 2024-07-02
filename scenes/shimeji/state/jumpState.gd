extends State
class_name JumpState

var shimeji: Shimeji
var isOnFloor: bool

func _ready():
	shimeji = get_parent().get_parent()


func _physics_process(delta):
	if(shimeji.global_position.y == get_viewport().size.y):
		isOnFloor = true
		
	if(isOnFloor):
		shimeji.velocity.y = JUMP_VELOCITY
		shimeji.velocity.x = 0
		isOnFloor = false
