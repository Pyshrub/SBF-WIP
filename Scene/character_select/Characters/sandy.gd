extends CharacterBody2D

@onready var SM = $StateMachine

const SPEED = 500.0
const JUMP_VELOCITY = -1000.0
const MAX_JUMP = -2000.0
@onready var hp = 500
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 1

func _ready():
	up_direction = Vector2.UP
	Global.P2_HP = hp
func _physics_process(delta):
	Global.P2_HP = hp
	velocity.y += gravity * delta + 150
	if direction < 0 and not $Sprite2D.flip_h: $Sprite2D.flip_h = true
	if direction > 0 and $Sprite2D.flip_h: $Sprite2D.flip_h = false

func set_direction(d):
	direction = d

func set_animation(anim):
	if $Anima.current_animation == anim: return
	if $Anima.has_animation(anim): $Anima.play(anim)
	else: $Anima.play()

func _on_hitbox_area_entered(area):
	Global.update_hp()
	SM.set_state("Damage")

