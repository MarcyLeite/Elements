extends Node
class_name StateMachine

@export var initial_state: State

var cur_state: State
var states: Dictionary = {}

func _ready():
	if Engine.is_editor_hint():
		return
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.state_changed.connect(on_state_transition)
	
	if initial_state:
		initial_state.enter()
		cur_state = initial_state

func _process(delta):
	if Engine.is_editor_hint():
		return
	if cur_state:
		cur_state.update(delta)
		
func _physics_process(delta):
	if Engine.is_editor_hint():
		return
	if cur_state:
		cur_state.physics_update(delta)

func on_state_transition(state, new_state_str):
	if state != cur_state:
		return
	
	var new_state = states[new_state_str]
	if not new_state:
		return

	if cur_state:
		cur_state.exit()
	new_state.enter()
	
	cur_state = new_state
