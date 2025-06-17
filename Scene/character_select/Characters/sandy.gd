extends CharacterBody2D

@onready var SM = $StateMachine

const SPEED = 500.0
const JUMP_VELOCITY = -1000.0
const MAX_JUMP = -2000.0
@onready var hp = 500
@onready var max_hp = 500
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 0
var stun_level
func _ready():
	up_direction = Vector2.UP
	Global.P2_HP = hp
	Global.P2_Max = hp
func _physics_process(delta):
	Global.P2_HP = hp
	Global.update_hp()
	velocity.y += gravity * delta + 150

func set_direction(d):
	direction = d

func set_animation(anim):
	if $Anima.current_animation == anim: return
	if $Anima.has_animation(anim): $Anima.play(anim)
	else: $Anima.play()

func damage(num):
	print(hp)
	hp -= num
	$Reset.start()
func _on_hitbox_area_entered(area):
	Global.update_hp()
	SM.set_state("Damage")
func knockback(k_level):
	stun_level = k_level
	$StateMachine.set_state("Damaged")


func _on_reset_timeout() -> void:
	hp = max_hp
	global_position.x = 700
