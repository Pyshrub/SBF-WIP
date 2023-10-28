extends Node

@onready var SM = get_parent()
@onready var player = get_node("../..")

func _ready():
	await player.ready

func start():
	player.set_animation("Damage")

func physics_process(_delta):
	player.move_and_slide()

	if player.is_on_floor():
		player.velocity.y = 0
		SM.set_state("Idle")
	if player.is_on_ceiling():
		player.velocity.y = 0
