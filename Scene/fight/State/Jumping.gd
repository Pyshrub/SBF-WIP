extends Node

@onready var SM = get_parent()
@onready var player = get_node("../..")
var direction
func _ready():
	await player.ready

func start():
	player.set_animation("jump")

func physics_process(_delta):
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
		player.velocity.x = player.direction * player.SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
	if Input.is_action_pressed("Jump"+str(player.player_num)) and player.velocity.y > player.MAX_JUMP:
		player.velocity.y += player.JUMP_VELOCITY
		player.move_and_slide()
	else:
		SM.set_state("Falling")
