extends Node

@onready var SM = get_parent()
@onready var enemy = get_node("../..")

func _ready():
	await enemy.ready

func start():
	enemy.velocity = Vector2.ZERO
	enemy.set_animation("Attack")
	$Timer.start()

func physics_process(_delta):
	pass


func _on_timer_timeout():
	if SM.state_name == "Attack":
		var target = enemy.attack_target()
		if target != null and target.name == "player_1":
			target.die()
