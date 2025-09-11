extends Node
@onready var SM = get_parent()
@onready var player = get_node("../..")
var stand_buffer = false
func _ready():
	await player.ready
func start():
	player.attack_type = "neutral_air"
	player.set_animation("neutral_air")
func _on_anima_animation_finished(anim_name):
	if anim_name == "neutral_air":
		SM.set_state("Falling")

func physics_process(delta):
	player.velocity.y += player.gravity * delta + 100
	player.move_and_slide()
