extends Node
@onready var SM = get_parent()
@onready var player = get_node("../..")
var stand_buffer = false
func _ready():
	await player.ready
func start():
	player.attack_type = "forward_air"
	player.set_animation("forward_air")
func _on_anima_animation_finished(anim_name):
	if anim_name == "forward_air":
		SM.set_state("Falling")

func physics_process(delta):
	player.velocity.y += player.gravity * delta + 100
	if player.is_on_floor():
		SM.set_state("Land_Lag")
	player.move_and_slide()
