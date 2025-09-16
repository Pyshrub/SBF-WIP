extends Node

@onready var SM = get_parent()
@onready var player = get_node("../..")
var direction
func _ready():
	await player.ready

func start():
	player.set_animation("jump")

func physics_process(delta):
	player.velocity.y += player.gravity * delta + 100
	if Input.is_action_pressed("Left"+str(player.player_num)):
		direction = -1
		if Input.is_action_pressed("Right"+str(player.player_num)):
			direction = 1
	if Input.is_action_pressed("Right"+str(player.player_num)):
		direction = 1
		if Input.is_action_pressed("Left"+str(player.player_num)):
			direction = -1
	if not Input.is_action_pressed("Left"+str(player.player_num)) and not Input.is_action_pressed("Right"+str(player.player_num)):
		direction = 0
	#player.set_direction(direction)
	if direction:
		player.velocity.x = lerp(player.velocity.x, direction * player.AIR_SPEED, player.AIR_ACCEL)
	else:
		player.velocity.x = lerp(player.velocity.x, 0.0, player.AIR_ACCEL)
	player.move_and_slide()

	if Input.is_action_just_pressed("Jab"+str(player.player_num)):
		SM.set_state("Neutral_Air")
	
	if player.is_on_floor():
		player.velocity.y = 0
		if player.velocity.x != 0:
			SM.set_state("Moving")
		elif player.velocity.x == 0:
			SM.set_state("Idle")
	if player.is_on_ceiling():
		player.velocity.y = 0
