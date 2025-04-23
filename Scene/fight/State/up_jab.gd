extends Node
@onready var SM = get_parent()
@onready var player = get_node("../..")
var glitter_strikes = 4
var multistrike_buffer = false
func _ready():
	await player.ready
func start():
	player.set_animation("up_jab_start")
	glitter_strikes = 4
func _on_anima_animation_finished(anim_name):
	if anim_name == "up_jab_end":
		print("ending anim")
		SM.set_state("Idle")
	elif anim_name == "up_jab_multi" or "up_jab_start": 
		if multistrike_buffer == false:
			print("help")
			player.set_animation("up_jab_end")
		elif multistrike_buffer == true:
			print("why isn't this working")
			player.set_animation("up_jab_multi")
			multistrike_buffer = false

func physics_process(_delta):
	print(glitter_strikes)
	if Input.is_action_just_pressed("Jab"+str(player.player_num)) and player.get_animation() == "up_jab_start":
		glitter_strikes = glitter_strikes - 1
		multistrike_buffer = true
	elif Input.is_action_just_pressed("Jab"+str(player.player_num)) and player.get_animation() == "up_jab_multi":
		glitter_strikes = glitter_strikes - 1
		multistrike_buffer = true
	if glitter_strikes <= 0:
		multistrike_buffer = false
		
