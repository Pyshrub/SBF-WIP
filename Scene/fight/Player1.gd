extends CharacterBody2D
var grounded = true
var speed = 20.0
const JUMP_VELOCITY = -400.0
@onready var player_move = $Avatar1
var t = 0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func get_input1():
	player_move.play("idle")
	if Input.is_action_pressed("Left"):
		velocity.x -= speed
		if velocity.x <= -1000:
			velocity.x = -1000
	if Input.is_action_just_released("Left"):
		velocity.x = 0
	if Input.is_action_pressed("Right"):
		player_move.play("run")
		velocity.x += speed
		if velocity.x >= 1000:
			velocity.x = 1000
	if Input.is_action_just_released("Right"):
		velocity.x = 0
	if Input.is_action_pressed("Up"):
		if grounded:
			velocity.y -= 100
			t += 1
			if t >= 20:
				print("Bup")
				grounded = false


func _physics_process(delta):
	get_input1()
	move_and_slide()

func _on_area_2d_body_entered(body):
	velocity.y = 0
	grounded = true


func _on_area_2d_body_exited(body):
		velocity.y += gravity
