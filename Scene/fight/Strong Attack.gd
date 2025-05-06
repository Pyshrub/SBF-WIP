extends Node
@onready var SM = get_parent()
@onready var player = get_node("../..")
var queued = false
func _ready():
	await player.ready
func start():
	player.attack_type = "Strong Attack"
	player.set_animation("strong_atk")
	queued = false
func _on_anima_animation_finished(anim_name):
	if anim_name == "strong_atk" and queued == false:
		SM.set_state("Idle")
	elif anim_name == "strong_atk2":
		SM.set_state("Idle")
func physics_process(_delta):
	if Input.is_action_just_pressed("Strong Attack"+str(player.player_num)) and queued == false:
		player.queue_animation("strong_atk2")
		queued = true
