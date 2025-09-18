extends CharacterBody2D

@onready var SM = $StateMachine


const SPEED = 600.0
const AIR_SPEED = 500.0
const JUMP_VELOCITY = -1000.0
const MAX_JUMP = -2000.0
const ACCEL = 0.15
const AIR_ACCEL = 0.1
@onready var Arena_Check = get_parent()
var attack_type
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 1
@onready var timing = $Combo
@onready var hit_window = $Hit_Window
var combo = false
@onready var hp = 200
@onready var max_hp = 200
var hitting = false
var player_num = 1
var stun_level
var type = "Player"
@onready var special_val = 0
@onready var sprite = $Sprite2D

var hit_dir
var hit_effect = preload("res://Scene/VFX/Hit_Effects/Test_Impact.tscn")
func _ready():
	up_direction = Vector2.UP
	$StateMachine/Damaged/Stun_Window.start()
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
		Global.P1_SP = special_val
	elif player_num == 2:
		Global.P2_HP = hp
		Global.P2_SP = special_val
	Global.update_hp()
	Global.update_sp()
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
	if Input.is_action_pressed("Special"+str(player_num)) and special_val >= 20:
		self.modulate = Color(0, 0, 1)
		special_val = 0
func set_direction(d):
	direction = d

func set_animation(anim):
	if $Anima.current_animation == anim: return
	if $Anima.has_animation(anim): $Anima.play(anim)
	else: $Anima.play()
	
func get_animation():
	return $Anima.current_animation
func queue_animation(anim):
	$Anima.queue(anim)

func _on_damage_area_entered(area):
	var target = area.owner
	if area.has_method("damage") == false:
		if target != self:
			if target.has_method("damage"):
				if position > target.position:
					target.set_direction(1)
				else:
					target.set_direction(-1)
				var new_hit_effect = hit_effect.instantiate()
				new_hit_effect.position = (target.position + position) / 2
				new_hit_effect.position += Vector2(176, 464 + $Flip_Container/damage/damage.position.y)
				get_parent().add_child(new_hit_effect)
				if attack_type == "jab":
					Hitstop.hit_stop(0.1)
					target.damage(3.5)
					target.knockback("small")
					special_val += 1
				if attack_type == "jab_2":
					Hitstop.hit_stop(0.1)
					target.damage(4.5)
					target.knockback("small")
					special_val += 1
				if attack_type == "up_jab":
					Hitstop.hit_stop(0.2)
					target.damage(5.5)
					target.knockback("up_small")
					special_val += 1
				if attack_type == "down_jab":
					Hitstop.hit_stop(0.15)
					target.damage(4.5)
					target.knockback("up_small")
					special_val += 1
				if attack_type == "Strong Attack":
					Hitstop.hit_stop(0.3)
					target.damage(10)
					target.knockback("Medium")
					special_val += 3
				if attack_type == "up_strong":
					Hitstop.hit_stop(0.3)
					target.damage(7)
					target.knockback("up_medium")
					special_val += 3
				if attack_type == "down_strong":
					Hitstop.hit_stop(0.3)
					target.damage(7)
					target.knockback("up_medium")
					special_val += 3
				if attack_type == "neutral_air":
					Hitstop.hit_stop(0.1)
					target.damage(3.5)
					target.knockback("up_small")
					special_val += 1
				if attack_type == "forward_air":
					Hitstop.hit_stop(0.2)
					target.damage(6)
					target.knockback("Medium")
					special_val += 2
				if attack_type == "up_air":
					Hitstop.hit_stop(0.2)
					target.damage(4.5)
					target.knockback("up_medium")
					special_val += 2
		if target.hp <= 0:
			target.die()

func damage(num):
	if attack_type == "Defending":
		hp = hp - (num*0.5)
	else:
		hp -= num
	special_val += num/4
func die():
	queue_free()
func _on_hit_window_timeout():
	hitting = false
func knockback(k_level):
	stun_level = k_level
	$StateMachine.set_state("Damaged")


func _on_hurt_area_entered(area: Area2D) -> void:
	pass
