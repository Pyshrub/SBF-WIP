extends Node
@onready var SM = get_parent()
@onready var player = get_node("../..")
var stand_buffer = false
func _ready():
	await player.ready
func start():
	player.attack_type = "up_strong"
	player.set_animation("Up_Strong")
func _on_anima_animation_finished(anim_name):
	if anim_name == "Up_Strong":
		SM.set_state("Idle")
