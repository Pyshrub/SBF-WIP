extends Node

@onready var SM = get_parent()
@onready var player = get_node("../..")
var direction
func _ready():
	await player.ready

func start():
	player.set_animation("run")

func physics_process(_delta):
	if not player.is_on_floor():
		SM.set_state("Falling")
	if Input.is_action_pressed("Jump"+str(player.player_num)):
		SM.set_state("Jumpsquat")

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
	player.set_direction(direction)
	if direction:
		player.velocity.x = lerp(player.velocity.x, direction * player.SPEED, player.ACCEL)
	else:
		player.velocity.x = lerp(player.velocity.x, 0.0, player.ACCEL)
	if player.Arena_Check.type == "wave":
		player.direction = direction
	else: pass
	player.move_and_slide()
	if direction == 0:
		SM.set_state("Idle")
	if Input.is_action_pressed("Down"+str(player.player_num)):
		player.velocity.x = 0
		SM.set_state("Down")
