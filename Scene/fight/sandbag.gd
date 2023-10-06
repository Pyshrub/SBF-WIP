extends CharacterBody2D
var grounded = true
var speed = 30.0
const JUMP_VELOCITY = -400.0
@onready var player_move = $Avatar1
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var state = "idle"
var idlecount = 0
var delay = false
var move = true
func get_input1():
	if state == "idle":
		player_move.play("idle")
	


func _physics_process(delta):
	get_node("Avatar1").set_flip_h(true)
	get_input1()
	move_and_slide()
	if grounded == false:
		player_move.play("jump")
		velocity.y += 100

func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	grounded = true
	if grounded == true and idlecount == 1:
		player_move.play("idle")
		idlecount = 0


func _on_avatar_1_animation_finished():
	delay = false
	state = "idle"
	


