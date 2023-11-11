extends Area2D
@onready var player = get_parent()
var hp
# Called when the node enters the scene tree for the first time.
func _ready():
	hp = player.hp


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player.hp = hp
func damage(num):
	player.hp -= num
