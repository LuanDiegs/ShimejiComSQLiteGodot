extends Node2D
class_name Action

enum ACTION_ENUM { move, jump, idle }
var state: ACTION_ENUM

func _ready():
	pass
	#timer.connect("timeout", randomizeAction)


func _physics_process(delta):
	pass
	

func randomizeAction():
	var newAction = ACTION_ENUM.values().pick_random()
	print(newAction)
	state = newAction
	return newAction;

