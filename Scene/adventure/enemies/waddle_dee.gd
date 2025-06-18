extends CharacterBody2D

@onready var anima = $AnimatedSprite2D
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var hp = 10
var stun_level
var direction = -1
var type = "enemy"
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	if direction:
		anima.play("walk")
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
func damage(num):
	hp = hp - num
	if hp <= 0:
		die()
func knockback(value):
	if value == "small":
		velocity.x = direction * -1 * 800
		$Stun_Window.start(.2)
	if value == "up_small":
		velocity.x = direction * -1 * 600
		velocity.y += -1000
		#SM.set_state("Falling")
	if value == "Medium":
		velocity.x = direction * -1 * 1000
		$Stun_Window.start(.5)
func die():
	queue_free()

func _on_hurt_area_entered(area: Area2D) -> void:
	pass # Replace with function body.


func _on_damage_area_entered(area):
	var target = area.owner
	if area.has_method("damage") == false:
		if target.type != "enemy":
			if target.has_method("damage"):
				target.damage(10)
				target.knockback("small")
