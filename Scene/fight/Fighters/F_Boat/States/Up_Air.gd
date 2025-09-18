extends Node
@onready var SM = get_parent()
@onready var player = get_node("../..")
var stand_buffer = false
func _ready():
	await player.ready
func start():
	player.attack_type = "up_air"
	player.set_animation("up_air")
func _on_anima_animation_finished(anim_name):
	if anim_name == "up_air":
		SM.set_state("Falling")

func physics_process(delta):
	player.velocity.y += player.gravity * delta + 100
	if player.is_on_floor():
		player.velocity.x = 0
	#	SM.set_state("Land_Lag")
	player.move_and_slide()
