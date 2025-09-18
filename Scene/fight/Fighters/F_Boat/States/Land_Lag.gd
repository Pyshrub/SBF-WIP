extends Node

@onready var SM = get_parent()
@onready var player = get_node("../..")

func _ready():
	await player.ready

func start():
	player.velocity = Vector2.ZERO
	player.set_animation("Land_Lag")

func _on_anima_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Land_Lag":
		SM.set_state("Idle")
