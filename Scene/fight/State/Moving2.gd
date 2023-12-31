extends Node

@onready var SM = get_parent()
@onready var player = get_node("../..")

func _ready():
	await player.ready

func start():
	player.set_animation("run")

func physics_process(_delta):
	if not player.is_on_floor():
		SM.set_state("Falling")
	if Input.is_action_pressed("Up_2"):
		SM.set_state("Jumping")
	if Input.is_action_just_pressed("Left_2") or Input.is_action_just_pressed("Right_2"):
		SM.set_state("Moving")
	var direction = Input.get_axis("Left_2", "Right_2")
	player.set_direction(direction)
	if direction:
		player.velocity.x = player.direction * player.SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
	player.move_and_slide()
	if direction == 0:
		SM.set_state("Idle")
