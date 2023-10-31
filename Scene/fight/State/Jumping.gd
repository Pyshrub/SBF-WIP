extends Node

@onready var SM = get_parent()
@onready var player = get_node("../..")
var direction
func _ready():
	await player.ready

func start():
	player.set_animation("jump")

func physics_process(_delta):
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
	if Input.is_action_pressed("Up") and player.velocity.y > player.MAX_JUMP:
		player.velocity.y += player.JUMP_VELOCITY
		player.move_and_slide()
	else:
		SM.set_state("Falling")
