extends CharacterBody2D

@onready var SM = $StateMachine

@export var walking = 500
@export var running = 500
@export var jump = 1200
var direction = 1

func _ready():
	velocity.x = running
	SM.set_state("Move")

func _physics_process(_delta):
	set_velocity(velocity)
	set_up_direction(Vector2.UP)
	move_and_slide()
	velocity = velocity
	
	if direction < 0 and not $Anima.flip_h: 
		$Anima.flip_h = true
	if direction > 0 and $Anima.flip_h: 
		$Anima.flip_h = false
	$Attack.target_position.x = direction*abs($Attack.target_position.x)
	$See.target_position.x = direction*abs($See.target_position.x)
	$Can_Jump.target_position.x = direction*abs($Can_Jump.target_position.x)
	
func set_animation(anim):
	if $Anima.animation == anim: return
	if $Anima.sprite_frames.has_animation(anim): $Anima.play(anim)
	else: $Anima.play()

func damage():
	if SM.state_name != "Die":
		SM.set_state("Die")


func should_attack():
	if $Attack.is_colliding() and $Attack.get_collider().name == "player_1":
		return true
	return false

func attack_target():
	if $Attack.is_colliding():
		return $Attack.get_collider()
	return null



func _on_above_and_below_body_entered(body):
	if body.name == "player_1" and SM.state_name != "Die":
		body.die()


func _on_anima_animation_finished():
	if SM.state_name == "Attack":
		SM.set_state("Move")
	if SM.state_name == "Die":
		queue_free()
