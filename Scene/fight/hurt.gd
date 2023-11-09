extends Area2D
@onready var player = get_node("../..")
var hp
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	hp = player.hp

func damage(num):
	player.hp -= num
	
func die():
	player.die()
