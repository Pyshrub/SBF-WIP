extends Node
@onready var SM = get_parent()
@onready var player = get_node("../..")
var queued = false
func _ready():
	await player.ready
func start():
	player.attack_type = "jab"
	player.set_animation("jab")
	queued = false
func _on_anima_animation_finished(anim_name):
	if anim_name == "jab" and queued == false:
		SM.set_state("Idle")
	elif anim_name == "jab2":
		SM.set_state("Idle")
func physics_process(_delta):
	if Input.is_action_just_pressed("Jab"+str(player.player_num)) and queued == false:
		player.queue_animation("jab2")
		queued = true
