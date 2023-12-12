extends Area2D
@onready var player = get_node("../..")
var hp
var state
var stagger = false
@onready var window = $Stagger_Window
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	hp = player.hp
	state = player.attack_type

	if player.hp <= 0:
		die()
func damage(num):
	if player.attack_type == "Defending":
		player.hp = hp - (num*0.5)
		print(player.hp)
	else:
		player.hp -= num
	
func die():
	player.die()
	
func knockback(num):
	if not stagger:
		player.velocity.x = 200 * num
		player.velocity.y = -1000
		stagger = true
		window.start()


func _on_stagger_window_timeout():
	stagger = false
func get_place():
	return player.position.x
