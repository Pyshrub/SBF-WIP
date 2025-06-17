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
		SM.set_state("Jumping")

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
	if direction:
		player.velocity.x = direction * player.SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
	player.move_and_slide()
	if direction == 0:
		SM.set_state("Idle")
	if Input.is_action_pressed("Down"+str(player.player_num)):
		player.velocity.x = 0
		SM.set_state("Down")
