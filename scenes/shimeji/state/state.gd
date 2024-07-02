extends Node
class_name State

const VELOCITY = 300;
const JUMP_VELOCITY = -500

var state
var currentSate
	
func _init():
	state = {
		"idle": IdleState,
		"walk": WalkState,
		"jump":JumpState
	}


func changeState(stateName):
	if get_child_count() != 0:
		get_child(0).queue_free()
		
	currentSate = state.get(stateName).new()
	currentSate.name = stateName
	
	if(stateName == "walk"):
		currentSate.direction = 1 if randi_range(0, 100) < 50 else -1
		
	add_child(currentSate)
	

func randomizeState():
	var newState: String
	var sort = randi_range(0, 10)
	
	if(sort >= 0 and sort <= 1):
		newState = "idle"
	elif (sort > 1 and sort <= 5):
		newState = "walk"
	elif(sort > 5 and sort <= 10):
		newState = "jump"
			
	return newState;
