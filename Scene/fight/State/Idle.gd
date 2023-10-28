extends Node

@onready var SM = get_parent()
@onready var player = get_node("../..")

func _ready():
	await player.ready

func start():
	player.velocity = Vector2.ZERO
	player.set_animation("Idle")

func physics_process(_delta):
	player.move_and_slide()
	if Input.is_action_just_pressed("Jab"):
		SM.set_state("Jab")
	if not player.is_on_floor():
		SM.set_state("Falling")
	if Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right"):
		SM.set_state("Moving")
	if Input.is_action_pressed("Up"):
		SM.set_state("Jumping")
