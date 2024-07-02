extends Label
class_name DeathShimejiToast

var message: String

@onready var animation_messages = $animationMessages

func _ready():
	animation_messages.connect("animation_finished", actionsAferFinishAnimation)
	self.text = message
	animation_messages.play("appear")

func actionsAferFinishAnimation(animationName):
	if(animationName == "appear"):
		queue_free()
