extends Node
@onready var SM = get_parent()
@onready var player = get_node("../..")
var stand_buffer = false
func _ready():
	await player.ready
func start():
	player.attack_type = "jab"
	player.set_animation("down_jab")
func _on_anima_animation_finished(anim_name):
	if anim_name == "down_jab":
		if stand_buffer == true:
			SM.set_state("Idle")
		else:
			SM.set_state("Down")

func physics_process(_delta):
	if Input.is_action_just_released("Down"+str(player.player_num)) and player.get_animation() == "down_jab":
		stand_buffer = true
