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
@onready var max_hp = 100
var hitting = false
var player_num = 1
func _ready():
	up_direction = Vector2.UP
	if Arena_Check.type == "wave":
		$Camera2D.enabled = true
	else:
		$Camera2D.enabled = false
	if player_num == 1:
		direction = 1
	elif player_num == 2:
		direction = -1
	if player_num == 1:
		Global.P1_HP = hp
	elif player_num == 2:
		Global.P2_HP = hp
func _physics_process(_delta):
	if player_num == 1:
		Global.P1_HP = hp
	elif player_num == 2:
		Global.P2_HP = hp
	Global.update_hp()
	if player_num == 1:	
		$Flip_Container/indicator.play("play1")
	elif player_num == 2:
		$Flip_Container/indicator.play("play2")
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
	
func get_animation():
	return $Anima.current_animation

func _on_damage_area_entered(area):
	if hitting == false:
		hit_window.wait_time = .4
		hit_window.start()
		hitting = true
		var target = area.owner
		if target.has_method("damage"):
			if attack_type == "jab":
				target.damage(7.5)
			if attack_type == "Strong Attack":
				target.damage(20)
		if target.hp <= 0:
			target.die()
	else:
		pass
func damage(num):
	if attack_type == "Defending":
		hp = hp - (num*0.5)
		print(hp)
	else:
		hp -= num
func die():
	queue_free()
func _on_hit_window_timeout():
	hitting = false
