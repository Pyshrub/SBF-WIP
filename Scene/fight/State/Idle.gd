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
	if Input.is_action_just_pressed("Jab"+str(player.player_num)):
		SM.set_state("Jab")
	if Input.is_action_just_pressed("Strong Attack"+str(player.player_num)):
		SM.set_state("Strong Attack")
	if not player.is_on_floor():
		SM.set_state("Falling")
	if Input.is_action_just_pressed("Left"+str(player.player_num)) or Input.is_action_just_pressed("Right"+str(player.player_num)):
		SM.set_state("Moving")
	if Input.is_action_pressed("Jump"+str(player.player_num)):
		SM.set_state("Jumping")
	if Input.is_action_pressed("Down"+str(player.player_num)):
		SM.set_state("Down")
	if Input.is_action_pressed("defend"+str(player.player_num)):
		SM.set_state("Defend")
	if Input.is_action_pressed("Up"+str(player.player_num)) and Input.is_action_just_pressed("Jab"+str(player.player_num)):
		SM.set_state("Up_Jab")
		#if Input.is_action_just_pressed("Jab2"):
			#SM.set_state("Jab")
		#if Input.is_action_just_pressed("Strong Attack2"):
			#SM.set_state("Strong Attack")
		#if not player.is_on_floor():
			#SM.set_state("Falling")
		#if Input.is_action_just_pressed("Left2") or Input.is_action_just_pressed("Right2"):
			#SM.set_state("Moving")
		#if Input.is_action_pressed("Up2"):
			#SM.set_state("Jumping")
		#if Input.is_action_pressed("Down2"):
			#SM.set_state("Down")
		#if Input.is_action_pressed("defend2"):
			#SM.set_state("Defend")
