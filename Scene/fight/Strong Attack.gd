extends Node
@onready var SM = get_parent()
@onready var player = get_node("../..")
func _ready():
	await player.ready
func start():
	player.attack_type = "Strong Attack"
	player.set_animation("strong_atk")
	player.timing.wait_time = 1
	player.timing.start()

	player.combo = true
func _on_anima_animation_finished(anim_name):
	pass
func physics_process(_delta):
	if Input.is_action_just_pressed("Strong Attack"+str(player.player_num)) and player.combo == true:
		player.timing.wait_time = 1.2
		player.timing.start()
		player.set_animation("strong_atk2")
		player.combo = false
	
func _on_combo_timeout():
	player.attack_type = ""
	player.combo = false
	SM.set_state("Idle")
