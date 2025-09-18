extends Node
@onready var SM = get_parent()
@onready var player = get_node("../..")


func _ready():
	await player.ready
func start():
	shake(0.15)
	player.set_animation("damaged")
	
	if Input.is_action_pressed("Left"+str(player.player_num)):
		player.position.x -= 20
	if Input.is_action_pressed("Right"+str(player.player_num)):
		player.position.x += 20
	
	
	if player.stun_level == "small":
		player.velocity.x = player.direction * -1 * 800
		$Stun_Window.start(.2)
	if player.stun_level == "up_small":
		player.velocity.x = player.direction * -1 * 600
		player.velocity.y = -2000
		$Stun_Window.start(.2)
		# SM.set_state("Falling")
	if player.stun_level == "up_medium":
		player.velocity.x = player.direction * -1 * 300
		player.velocity.y = -3500
		$Stun_Window.start(.3)
		# SM.set_state("Falling")
	if player.stun_level == "Medium":
		player.velocity.x = player.direction * -1 * 1500
		player.velocity.y += -1500
		$Stun_Window.start(.5)
	
func _on_anima_animation_finished(anim_name):
	pass
func physics_process(delta):
	player.move_and_slide()
	player.velocity.x = move_toward(player.velocity.x, 0, 200)
	player.velocity.y += player.gravity * delta + 100


func _on_stun_window_timeout() -> void:
	SM.set_state("Idle")

func shake(length):
	player.sprite.material.set_shader_parameter("hit_effect", 1.0)
	await get_tree().create_timer(length, true, false, true).timeout
	player.sprite.material.set_shader_parameter("hit_effect", 0)
