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
	if Input.is_action_pressed("Left"):
		direction = -1
		if Input.is_action_pressed("Right"):
			direction = 1
	if Input.is_action_pressed("Right"):
		direction = 1
		if Input.is_action_pressed("Left"):
			direction = -1
	if not Input.is_action_pressed("Left") and not Input.is_action_pressed("Right"):
		direction = 0
	player.set_direction(direction)
	if direction:
		player.velocity.x = player.direction * player.SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
	player.move_and_slide()

	if player.is_on_floor():
		player.velocity.y = 0
		if player.velocity.x != 0:
			SM.set_state("Moving")
		elif player.velocity.x == 0:
			SM.set_state("Idle")
	if player.is_on_ceiling():
		player.velocity.y = 0
