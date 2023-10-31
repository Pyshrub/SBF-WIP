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
	if Input.is_action_pressed("Up"):
		SM.set_state("Jumping")

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
	if direction == 0:
		SM.set_state("Idle")
