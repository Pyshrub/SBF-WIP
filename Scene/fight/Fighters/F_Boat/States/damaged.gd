extends Node
@onready var SM = get_parent()
@onready var player = get_node("../..")
func _ready():
	await player.ready
func start():
	player.set_animation("damaged")
	if player.stun_level == "small":
		player.velocity.x = player.direction * -1 * 800
		$Stun_Window.start(.2)
	if player.stun_level == "up_small":
		player.velocity.x = player.direction * -1 * 600
		player.velocity.y = -1000
		SM.set_state("Falling")
	if player.stun_level == "Medium":
		player.velocity.x = player.direction * -1 * 1000
		$Stun_Window.start(.5)
func _on_anima_animation_finished(anim_name):
	pass
func physics_process(_delta):
	player.move_and_slide()
	player.velocity.x = move_toward(player.velocity.x, 0, 200)


func _on_stun_window_timeout() -> void:
	print("check")
	SM.set_state("Idle")
