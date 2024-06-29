extends Node2D
class_name Action

enum ACTION_ENUM { move, jump, idle }

func _ready():
	pass
	#timer.connect("timeout", randomizeAction)


func _physics_process(delta):
	pass
	

func randomizeAction():
	var newAction: ACTION_ENUM
	var sort = randi_range(0, 10)
	
	if(sort >= 0 and sort <= 1):
		newAction = ACTION_ENUM.idle
	elif (sort > 1 and sort <= 5):
		newAction = ACTION_ENUM.move
	elif(sort > 5 and sort <= 10):
		newAction = ACTION_ENUM.jump
			
	return newAction;

