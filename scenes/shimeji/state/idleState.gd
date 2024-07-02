extends State
class_name IdleState

var shimeji: Shimeji

func _ready():
	shimeji = get_parent().get_parent()
	pass


func _physics_process(delta):
	shimeji.velocity.x = lerp(shimeji.velocity.x, 0.0, 0.2)
