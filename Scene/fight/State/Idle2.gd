extends Node

@onready var SM = get_parent()
@onready var player = get_node("../..")

func _ready():
	await player.ready

func start():
	player.velocity = Vector2.ZERO
	player.set_animation("Idle")

func physics_process(_delta):
	if not player.is_on_floor():
		SM.set_state("Falling")
	if Input.is_action_just_pressed("Left_2") or Input.is_action_just_pressed("Right_2"):
		SM.set_state("Moving")
	if Input.is_action_pressed("Up_2"):
		SM.set_state("Jumping")
	if Input.is_action_just_pressed("Jab2"):
		SM.set_state("Jab")
