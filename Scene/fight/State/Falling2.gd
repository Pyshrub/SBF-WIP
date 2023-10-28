extends Node

@onready var SM = get_parent()
@onready var player = get_node("../..")

func _ready():
	await player.ready

func start():
	player.set_animation("jump")

func physics_process(delta):
	player.velocity.y += player.gravity * delta + 100
	var direction = Input.get_axis("Left_2", "Right_2")
	if direction: 
		player.velocity.x = player.direction * player.SPEED
	else: 
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)

	player.set_direction(direction)
	player.move_and_slide()

	if player.is_on_floor():
		player.velocity.y = 0
		if player.velocity.x != 0:
			SM.set_state("Moving")
		elif player.velocity.x == 0:
			SM.set_state("Idle")
	if player.is_on_ceiling():
		player.velocity.y = 0
