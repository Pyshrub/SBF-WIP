extends Node

@onready var SM = get_parent()
@onready var player = get_node("../..")

func _ready():
	await player.ready
var combo
func start():
	player.set_animation("jab")
	var combo = true
	get_node("res/").start()

func _on_anima_animation_finished(anim_name):
	if Input.is_action_just_pressed("Jab") and combo == true:
		player.set_animation("jab2")
	if combo == false:
		SM.set_state("Idle")



func _on_combo_timeout():
	combo = false
