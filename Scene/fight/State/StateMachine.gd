extends Node

var state = null
var previous_state = null
var state_name = ""

func _ready():
	set_state(get_children()[0].name)

func _physics_process(delta):
	if state and state.has_method("physics_process"):
		state.physics_process(delta)

func _process(delta):
	if state and state.has_method("process"):
		state.process(delta)

func _unhandled_input(event):
	if state and state.has_method("unhandled_input"):
		state.unhandled_input(event)

func set_state(s):
	state_name = s
	var new_state = get_node(NodePath(s))
	if state != null:
		if state.has_method("end"):
			state.end()
		previous_state = state
	if new_state != null:
		state = new_state
		if state.has_method("start"):
			state.start()
