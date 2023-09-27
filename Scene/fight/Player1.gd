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
	if move == true:
		if Input.is_action_pressed("Left"):
			velocity.x -= speed
			if velocity.x <= -600:
				velocity.x = -600
			get_node("Avatar1").set_flip_h(true)
			player_move.play("run")
			state = "running"
		if Input.is_action_just_released("Left"):
			velocity.x = 0
			state = "idle"
		if Input.is_action_pressed("Right"):
			velocity.x += speed
			if velocity.x >= 600:
				velocity.x = 600
			player_move.play("run")
			get_node("Avatar1").set_flip_h(false)
			state = "running"
		if Input.is_action_just_released("Right"):
			velocity.x = 0
			state = "idle"
	if Input.is_action_pressed("Up"):
		if grounded:
			velocity.y = -2000
			idlecount = 1
			grounded = false
			move = true
	if delay == false:
		if Input.is_action_pressed("Strong Attack"):
			player_move.play("str_atk")
			state = "Attack"
			delay = true
		if Input.is_action_just_released("Strong Attack"):
			pass
		if Input.is_action_pressed("Jab"):
			player_move.play("jab")
			state = "Attack"
			delay = true
		if Input.is_action_just_released("Jab"):
			pass
	if Input.is_action_pressed("Down"):
		player_move.play("down")
		velocity.x = 0
		state = "down"
		move = false
	if Input.is_action_just_released("Down"):
		state = "idle"
		move = true
	if Input.is_action_pressed("defend"):
		player_move.play("defend")
		velocity.x = 0
		state = "guard"
		move = false
	if Input.is_action_just_released("defend"):
		state = "idle"
		move = true
	if state == "idle":
		player_move.play("idle")
	


func _physics_process(delta):
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
	


