extends CharacterBody2D

@onready var SM = $StateMachine


const SPEED = 500.0
const JUMP_VELOCITY = -1000.0
const MAX_JUMP = -2000.0
@onready var Arena_Check = get_parent()
var attack_type
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 1
@onready var timing = $Combo
@onready var hit_window = $Hit_Window
var combo = false
@onready var hp = 100
var hitting = false
func _ready():
	up_direction = Vector2.UP
	if Arena_Check.type == "wave":
		$Camera2D.enabled = true
	else:
		$Camera2D.enabled = false
func _physics_process(_delta):
	Global.P1_HP = hp
	Global.update_hp()
	$Flip_Container/indicator.play("default")
	if direction < 0 and not $Sprite2D.flip_h: 
		$Sprite2D.flip_h = true
		$Flip_Container.transform.x.x = -1
		$Flip_Container.position.x += 345
		$Body.transform.x.x = -1
		$Body.position.x += 30
	if direction > 0 and $Sprite2D.flip_h:
		$Sprite2D.flip_h = false
		$Flip_Container.transform.x.x = 1
		$Flip_Container.position.x -= 345
		$Body.transform.x.x = 1
		$Body.position.x -= 30
	else:
		pass
func set_direction(d):
	direction = d

func set_animation(anim):
	if $Anima.current_animation == anim: return
	if $Anima.has_animation(anim): $Anima.play(anim)
	else: $Anima.play()

func _on_damage_area_entered(area):
	if hitting == false:
		hit_window.wait_time = .4
		hit_window.start()
		hitting = true
		var target = area
		if target.has_method("damage"):
			if attack_type == "jab":
				target.damage(7.5)
				if area.global_position.x < global_position.x:
					print("hi")
					area.knockback(-5)
			if attack_type == "Strong Attack":
				target.damage(20)
		if target.hp <= 0:
			target.die()
	else:
		pass
func die():
	queue_free()
func _on_hit_window_timeout():
	hitting = false
