extends Node

@onready var SM = get_parent()
@onready var player = get_node("../..")

func _ready():
	await player.ready

func start():
	player.set_animation("jump")

func physics_process(_delta):
	if Input.is_action_pressed("Up") and player.velocity.y > player.MAX_JUMP:
		player.velocity.y += player.JUMP_VELOCITY
		player.move_and_slide()
	else:
		SM.set_state("Falling")
