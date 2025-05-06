extends Node
@onready var SM = get_parent()
@onready var player = get_node("../..")
var count = 0
var queued = false
var current_anim
func _ready():
	await player.ready
func start():
	player.set_animation("up_jab_start")
	count = 0
func _on_anima_animation_changed(old_name: StringName, new_name: StringName) -> void:
	print(new_name)
	if new_name == "up_jab_multi" or new_name == "up_jab_multi_2":
		queued = false
	else:
		print(queued)
		
func _on_anima_animation_finished(anim_name):
	if anim_name == "up_jab_end":
		SM.set_state("Idle")
	elif anim_name == "up_jab_multi" or anim_name == "up_jab_start" or anim_name =="up_jab_multi_2":
		if queued == false:
			player.set_animation("up_jab_end")
		else:
			print("error")
	else:
		pass

func physics_process(_delta):
	player.attack_type = "up_jab"
	current_anim = player.get_animation()
	if count <= 2:
		if Input.is_action_just_pressed("Jab"+str(player.player_num)) and queued == false:
			if current_anim == "up_jab_multi":
				player.queue_animation("up_jab_multi_2")
			else:
				player.queue_animation("up_jab_multi")
			queued = true
			count += 1
