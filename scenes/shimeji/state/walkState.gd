extends State
class_name WalkState

var shimeji: Shimeji
var ray_cast_right: RayCast2D
var ray_cast_left: RayCast2D

var direction: int

func _ready():
	shimeji = get_parent().get_parent()
	ray_cast_right = shimeji.get_node("RayCastRight")
	ray_cast_left = shimeji.get_node("RayCastLeft")


func _physics_process(delta):
	if(ray_cast_right.global_position.x >= get_viewport().size.x or ray_cast_left.global_position.x <= 0):
		direction = 1 if direction == -1 else -1
		
	shimeji.velocity.x = direction * VELOCITY
