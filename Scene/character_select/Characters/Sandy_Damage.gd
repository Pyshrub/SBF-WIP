extends Node

@onready var SM = get_parent()
@onready var player = get_node("../..")

func _ready():
	await player.ready

func start():
	player.set_animation("Damage")
	player.velocity.x += 200
func physics_process(_delta):
	player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
	player.move_and_slide()
	
func _on_anima_animation_finished(anim_name):
	if anim_name == "Damage":
		SM.set_state("Idle")
