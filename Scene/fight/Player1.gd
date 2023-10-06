extends CharacterBody2D
var grounded = true
var speed = 30.0
@onready var player_move = $Anima
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var state = "idle"
var idlecount = 0
var delay = false
var move = true
var tap = 0
var stap = 0
@onready var combotime = get_node("combotime")
@onready var delaytime = get_node("delaytime")
func get_input1():
	if move == true:
		if Input.is_action_pressed("Left"):
			velocity.x -= speed
			if velocity.x <= -600:
				velocity.x = -600
			if velocity.x >= 0:
				velocity.x = 0
			get_node("Sprite2D").set_flip_h(true)
			player_move.play("run")
			state = "running"
		if Input.is_action_just_released("Left"):
			velocity.x = 0
			state = "idle"
		if Input.is_action_pressed("Right"):
			velocity.x += speed
			if velocity.x <= 0:
				velocity.x = 0
			if velocity.x >= 600:
				velocity.x = 600
			player_move.play("run")
			get_node("Sprite2D").set_flip_h(false)
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
		if tap == 3:
			if Input.is_action_pressed("Strong Attack"):
				player_move.play("strong_atk2")
				state = "Attack"
				time("delay", .8)
		else:
			if Input.is_action_pressed("Strong Attack"):
				player_move.play("strong_atk")
				state = "Attack"
				time("combo", .9)
				time("delay", .7)
				tap = 3
			if Input.is_action_just_released("Strong Attack"):
				pass
		if tap == 1:
			if Input.is_action_pressed("Jab"):
				state = "Attack"
				player_move.play("jab2")
				time("delay", .8)
			if Input.is_action_just_released("Jab"):
				pass
		else:
			if Input.is_action_pressed("Jab"):
				print("jab")
				state = "Attack"
				player_move.play("jab")
				time("delay", .45)
				time("combo", 1)
				tap = 1
			if Input.is_action_just_released("Jab"):
				pass
		if Input.is_action_pressed("Down"):
			velocity.x = 0
			state = "down"
			move = false
			if Input.is_action_pressed("Jab"):
				player_move.play("down_jab")
				time("delay", 1)
			elif Input.is_action_pressed("Strong Attack"):
				player_move.play("down_strong")
				time("delay", 1.3)
			else:
				player_move.play("down")
	if Input.is_action_just_released("Down"):
		if not delay:
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
		player_move.play("Idle")


	


func _physics_process(delta):
	get_input1()
	move_and_slide()
	if grounded == false:
		state = "jump"
		velocity.y += 100
		idlecount += 1
		player_move.play("jump")

func _on_damage_body_entered(body):
	print("Hit")

	
func time(type, wait):
	if type == "combo":
		combotime.set_wait_time(wait)
		combotime.start()
	if type == "delay":
		delaytime.set_wait_time(wait)
		delay = true
		delaytime.start()
	

func _on_combotime_timeout():
	tap = 0


func _on_delay_timeout():
	delay = false
	state = "idle"


func _on_anima_animation_finished(anim_name):
	delay = false


func _on_damage_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	print("hit")


func _on_floor_area_entered(area):
	grounded = true
	if idlecount >= 1:
		player_move.play("Idle")
		idlecount = 0
