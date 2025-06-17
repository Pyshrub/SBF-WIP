extends Node
@onready var SM = get_parent()
@onready var player = get_node("../..")
func _ready():
	await player.ready
func start():
	player.set_animation("down")

func _on_anima_animation_finished(anim_name):
	pass
func physics_process(_delta):
	if Input.is_action_just_released("Down"+str(player.player_num)):
		SM.set_state("Idle")
	if Input.is_action_just_pressed("Jab"+str(player.player_num)):
		SM.set_state("Down_Jab")
